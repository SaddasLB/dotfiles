#!/usr/bin/env sh

# set neovim as default editor
EDITOR="nvim"

# check if any editor flag has been used (ex. -e nano)
while getopts "e:" opt; do
    case $opt in
        e)
            EDITOR="$OPTARG"
            ;;
        *)
            echo "Uso: $0 [-e editor]"
            exit 1
            ;;
    esac
done

# shift ignores flag parameters
shift $((OPTIND -1))

# set fetching directory
DIR="$HOME/.config/hypr/xcfg/"  # Puoi cambiare questo percorso
XCFG_DIR="$HOME./config/hypr"
# list directory files
FILES=$(ls -1 "$DIR")

# list second directory files
XCFG_FILES=$(ls -1 "$XCFG_DIR")

# convert list to array
FILE_ARRAY=($FILES, $XCFG_FILES)

# shows numbered list
echo -e "\n-----------------------------------------\n\nScegli un file da aprire:"
for i in "${!FILE_ARRAY[@]}"; do
    if [[ $FILE_ARRAY[@] -eq "xcfg"]]; then
      break      
    fi
    echo "$((i+1))) ${FILE_ARRAY[$i]}"
done

# get user input
read -p "Inserisci il numero del file da aprire: " FILE_INDEX

# check if input is valid
if [ "$FILE_INDEX" -gt 0 ] && [ "$FILE_INDEX" -le "${#FILE_ARRAY[@]}" ]; then
    FILE_TO_OPEN="${FILE_ARRAY[$((FILE_INDEX-1))]}"
    echo -e "\nFILE: $FILE_TO_OPEN\nEDITOR: $EDITOR"

    # open file with chosen editor
    "$EDITOR" "$DIR/$FILE_TO_OPEN"
else
    echo "ERROR: invalid number"
    
    exit 1
fi

