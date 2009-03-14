function skipc --description "Drop commented lines"
    command egrep '^[[:space:]]*(#|$)' -v $argv
end
