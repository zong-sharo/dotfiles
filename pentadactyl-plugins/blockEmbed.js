"use strict";
plugins.blockEmbed = (function(){
// --------------------------------------------------------
// XBL
// --------------------------------------------------------
let xblBinding =
<bindings xmlns="http://www.mozilla.org/xbl"
          xmlns:html="http://www.w3.org/1999/xhtml">
    <binding id="blockEmbed">
        <implementation>
            <constructor>
                <![CDATA[
                // prevents re-blocking
                if (this.getAttribute('blockEmbed') || this.parentNode.getAttribute('blockEmbed'))
                    return;

                function inheritSize(src, dest) {
                    ['width', 'height'].forEach(function(a) {
                            if (src[a])
                                if (/[^0-9]$/.test(src[a]))
                                    dest.style[a] = src[a];
                                else
                                    dest.style[a] = parseInt(src[a]) + 'px';
                                    });
                };

                function copyAttributes(src, dest) {
                    Array.forEach(src.attributes, function (attr) {
                            dest.setAttribute(attr.name, attr.value);
                            });
                };

                function blockRequest () {
                    var event = document.createEvent('Events');
                    event.initEvent('blockEmbed_blockRequest', true, true);
                    return document.dispatchEvent(event);
                };

                function Wrapper (wrapee, placeholder) {
                    this.active = false;
                    this.parentNode = wrapee.parentNode;
                    this.wrapee = wrapee;
                    this.placeholder = placeholder;

                    wrapee.setAttribute('blockEmbed', 'show');
                };

                Wrapper.prototype = {
                    hide : function () {
                        if (this.active)
                            return;
                        this.parentNode.replaceChild(this.placeholder, this.wrapee);
                        this.wrapee.setAttribute('blockEmbed', 'hide');
                        this.active = true;
                    },
                    show : function () {
                        if (!this.active)
                            return;
                        this.parentNode.replaceChild(this.wrapee, this.placeholder);
                        this.wrapee.setAttribute('blockEmbed', 'show');
                        this.active = false;
                    }
                };

                var placeholder = document.createElement('embedplaceholder');
                copyAttributes(this, placeholder); // helps to avoid some styling issues
                inheritSize(this, placeholder);

                var wrapper = new Wrapper(this, placeholder);

                // XXX SECURITY filter out synthetic events if such thing exists
                placeholder.addEventListener('click', function () {wrapper.show(); }, false);

                window.addEventListener('message', function(event) {
                    if (event.origin !== 'chrome://browser')
                        return;
                    if (event.data == 'blockEmbed:show')
                        wrapper.show()
                    else if (event.data == 'blockEmbed:hide')
                        wrapper.hide()
                    else if (event.data == 'blockEmbed:refresh')
                    {
                        if (blockRequest()) wrapper.hide()
                        else wrapper.show()
                    }
                        
                    }, false);

                if (blockRequest())
                    wrapper.hide()
                ]]>
            </constructor>
        </implementation>
    </binding>
</bindings>;

let style = <![CDATA[
    embedplaceholder {
        display: inline-block;
        min-width: 32px !important;
        min-height: 32px !important;
        border: 1px solid black;
        cursor: pointer;
        overflow: hidden;
        -moz-box-sizing: border-box;
        background-color: white !important;
        color: black !important;
    }
    embed,
    object {
        -moz-binding: url("{data-uri-encoded-xlb-binding}") !important;
    }

/*    embed:not([blockEmbed="show"]),
    object:not([blockEmbed="show"]) {
        display: none !important;
    }
*/
]]>.toString().replace('{data-uri-encoded-xlb-binding}', 'chrome-data:text/xml,' + encodeURIComponent('<?xml version="1.0"?>' + xblBinding.toXMLString()));

styles.system.add('blockEmbed', '*', style);

// --------------------------------------------------------
// UI
// --------------------------------------------------------

options.add(['blockembed'],
    'Enable blocking of embedded objects',
    'boolean', true,
    {setter: refreshPlaceholders});

// TODO move interop to interop section
commands.addUserCommand(['embedshow'],
    'Show all embedded objects on the current page',
    function () { content.postMessage('blockEmbed:show', '*'); },
    { argCount: '0' });
commands.addUserCommand(['embedhide'],
    'Hide all embedded objects on the current page',
    function () { content.postMessage('blockEmbed:hide', '*'); },
    { argCount: '0' });
commands.addUserCommand(['embedtoggle'],
    'Toggle all embedded objects on the current page',
    function () {
        if (util.evaluateXPath('//embedplaceholder').snapshotLength)
            commands.get('embedshow').action();
        else
            commands.get('embedhide').action();
    },
    { argCount: '0'});

// --------------------------------------------------------
// XBL <-> Priveleged code interop
// --------------------------------------------------------
function refreshPlaceholders (value) {
    for (let [,t] in tabs.browsers)
        t.contentWindow.postMessage('blockEmbed:refresh', '*');
    return value;
};

function blockRequestHandler (event) {
    event.stopPropagation();
    if (options.get('blockembed').value && !plugins.blockEmbed.getPermission(event.target.domain.toLowerCase()))
        return;
    event.preventDefault();
};
window.addEventListener('blockEmbed_blockRequest', function (e) { blockRequestHandler(e)} , true, true);

// --------------------------------------------------------
// Storage
// --------------------------------------------------------
let databaseFile = Components.classes['@mozilla.org/file/directory_service;1'].getService(Components.interfaces.nsIProperties).get('ProfD', Components.interfaces.nsIFile);
databaseFile.append('blockEmbed.sqlite');
let storageService = Components.classes['@mozilla.org/storage/service;1'].getService(Components.interfaces.mozIStorageService);
let connection = storageService.openDatabase(databaseFile);

if (!connection.tableExists('rules'))
    connection.createTable('rules', 'domain STRING PRIMARY KEY, permission BOOLEAN NOT NULL');

let getStatement = connection.createStatement('SELECT permission from rules where domain = :domain');
let setStatement = connection.createStatement('INSERT OR REPLACE INTO rules values(:domain, :permission)');
let unsetStatement = connection.createStatement('DELETE FROM rules where domain = :domain');
let listStatement = connection.createStatement('SELECT domain, permission from rules ORDER BY domain');

function isSubdomain(domain) {
    let count = 0;
    for (let i = 0; i < domain.length; i++)
        if (domain.charAt(i) === '.')
            count++;
    return count >=2;
};

function parentDomain(domain) {
    return domain.slice(domain.indexOf('.')+1);
};

// --------------------------------------------------------
// API
// --------------------------------------------------------
function getPermission (domain) {
    getStatement.params.domain = domain;
    try {
        if (getStatement.executeStep())
            return !!getStatement.row.permission;
    } finally {
        getStatement.reset();
    };
    if (isSubdomain(domain))
        return getPermission(parentDomain(domain));
    return false;
};

return {
    addRule : function (domain, permission) {
        setStatement.params.domain = domain;
        setStatement.params.permission = permission ? 1 : 0;
        setStatement.executeAsync();
    },
    getPermission : getPermission,
    removeRule : function (domain) {
        unsetStatement.params.domain = domain;
        unsetStatement.executeAsync();
    },
    listRules : function () {
        let rules = [];
        try {
            while (listStatement.executeStep())
                rules.push({domain : listStatement.row.domain, permission : !!listStatement.row.permission});
        } finally {
            listStatement.reset();
        };
        return rules;
    },
    refreshPlaceholders : refreshPlaceholders
    };
})();
