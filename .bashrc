if [[ -n $PS1 && -f ~/.bash_prompt ]]; then
  . ~/.bash_prompt
  ps1_white_theme
fi

function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }
