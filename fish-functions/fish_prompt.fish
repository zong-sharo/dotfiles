function fish_prompt

    switch $USER
        case root

        printf '%s%s@%s %s#%s ' (set_color -o red) (whoami) (hostname|cut -d . -f 1) (set_color -o blue) (set_color normal)
        case '*'

        printf '%s%s@%s %s%%%s ' (set_color -o green) (whoami) (hostname|cut -d . -f 1) (set_color -o blue) (set_color normal)
    end
end
