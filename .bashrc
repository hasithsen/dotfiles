if [[ -n $PS1 && -f ~/.bash_prompt ]]; then
  . ~/.bash_prompt
  ps1_white_theme
fi

# Decode a URL-encoded string
function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# Set the screen to sepia mode
function sepia() { xcalib -red 1.7 1 64 -green 1.7 1 57 -blue 1.7 1 28 -alter; }

# See certificate details for a given domain
function seecert () {
  nslookup $1
  (openssl s_client -showcerts -servername $1 -connect $1:443 <<< "Q" | openssl x509 -text | grep -iA2 "Validity")
}

# Convert all books of a given extension to Kindle format (.azw3)
function kindlize () {
  for book in *.$1; do
    echo "Converting $book"
    ebook-convert "$book" "$(basename "$book" .$1).azw3";
  done
}

# cleanup docker containers, images, and volumes matching a string
function dc () {
    if [ -z "$1" ]; then
        echo "Error: Please provide a string to match."
        echo "Usage: dc <string>"
        return 1
    fi

    local STR="$1"
    echo "Stopping and removing resources matching: '$STR'..."

    # Stop and remove containers (with volumes)
    local containers=$(docker ps -a -q -f name="$STR")
    if [ -n "$containers" ]; then
        docker stop $containers 2>/dev/null
        docker rm -v $containers
    fi

    # Remove matching images
    local images=$(docker images -q --filter reference="*$STR*")
    if [ -n "$images" ]; then
        docker rmi $images
    fi

    # Remove matching volumes
    local volumes=$(docker volume ls -q -f name="$STR")
    if [ -n "$volumes" ]; then
        docker volume rm $volumes
    fi

    echo "Cleanup complete!"
}
