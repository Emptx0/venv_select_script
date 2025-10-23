#!/usr/bin/env zsha

PY_VENVS_PATH=$HOME/.virtualenvs

venvselect() {
    local selected_venv="$1"

    if [ -z "$selected_venv" ]; then
        printf "Default venvs directory: \e[1;34m$PY_VENVS_PATH\e[0m\n\n"
        echo "Available venvs:"
        ls "$PY_VENVS_PATH"
        return
    fi
 
    if [ ! -d  "$PY_VENVS_PATH/$selected_venv" ]; then
        printf "No \e[1;34m%s\e[0m venv in \e[1;34m$PY_VENVS_PATH\e[0m\n" "$selected_venv"
        return
    fi

    if [ ! -f "$PY_VENVS_PATH/$selected_venv"/bin/activate ]; then
        printf "No \e[1;34mbin/activate\e[0m in \e[1;34m%s\e[0m\n" "$vevns_path/$selected_venv"
        printf "\e[90mTry to find it by yourself.\e[0m\n"
        return
    fi

    cd "$PY_VENVS_PATH/$selected_venv"
    source bin/activate
}

# Autocompletion
_venvselect_completions() {
    local -a venvs_list

    venvs=($PY_VENVS_PATH/*(N:t))
    (( ${#venvs} )) || return 0

    compadd "$@" -- "${venvs[@]}"
}
compdef _venvselect_completions venvselect
