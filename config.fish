set -gx GREP_OPTIONS --color=auto
set -gx GREP_COLOR '0;37;43' # red bg
set -gx LESS '-cx4MiR' # clear screen, tabstop=4, long prompt, smart ignorecase, accept colors
set -gx EDITOR vim

set PATH ~/bin $PATH

if test -d ~/local
    
    if which python > /dev/null
        set -l python_version (python -V 2>| cut -c8-10)

        set -gx PYTHONPATH $PYTHONPATH (find ~/local -path '*/lib*/python'$python_version'/site-packages' -type d)
    end

    set -gx PATH $PATH (find ~/local -maxdepth 3 -regex '.*/bin\(32\|64\)?' -type d)
    set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH (find ~/local -maxdepth 3 -regex '.*/lib\(32\|64\)?')
    set -gx MANPATH $MANPATH (find ~/local -maxdepth 3 -path '*/share/man' -type d)

end

set -e fish_greeting

function fish_title
    if test $_ != 'fish'
        set job $_
    end
        
    set -gx fish_title_string ( printf '%s@%s:%s %s' (whoami) (hostname|cut -d . -f 1) (pwd) $job )
    echo $fish_title_hook_variable
end

if test $TERM = 'screen'
    function screen_title --on-variable fish_title_string # damn hack
        printf '\033k%s\033\\' $fish_title_string
    end
end

# missing features:
# * rprompt
# * jobs argv
# * zsh-like completion print
