if [[ -n $PS1 && -f ~/.bash_prompt ]]; then
  . ~/.bash_prompt
  ps1_white_theme
fi

function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

function sepia() { xcalib -red 1.7 1 64 -green 1.7 1 57 -blue 1.7 1 28 -alter; }

function seecert () {
  nslookup $1
  (openssl s_client -showcerts -servername $1 -connect $1:443 <<< "Q" | openssl x509 -text | grep -iA2 "Validity")
}
