function skipc --description "Drop commented lines"
    command egrep '^#|^\s*$' -v $argv
end
