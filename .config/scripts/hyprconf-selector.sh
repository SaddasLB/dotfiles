#!/usr/bin/env sh

# set neovim as default editor
EDITOR="nano"

# check if any editor flag has been used (ex. -e nano)
while getopts "e:" opt; do
    case $opt in
        e)
            EDITOR="$OPTARG"
            ;;
        *)
            echo "Using: $0 [-e editor]"
            exit 1
            ;;
    esac
done

# shift ignores flag parameters
shift $((OPTIND -1))

# set fetching directories
DIR="$HOME/.config/hypr"  
XCFG_DIR="$HOME/.config/hypr/xcfg/"

# list directory files
FILES=($(ls -1 "$DIR"))
XCFG_FILES=($(ls -1 "$XCFG_DIR"))

# convert list to array
FILE_MERGE=("${FILES[@]}" "${XCFG_FILES[@]}")

# create new array without directories
declare -a FILE_ARRAY=()
for file in "${FILE_MERGE[@]}"; do
    if ! [ -d "$DIR/$file" ] && ! [ -d "$XCFG_DIR/$file" ]; then
        FILE_ARRAY+=("$file")
    fi
done

# shows numbered list
echo -e "\n-----------------------------------------\n\nChoose a file to edit:"
for i in "${!FILE_ARRAY[@]}"; do
    echo "$((i+1))) ${FILE_ARRAY[$i]}"
done

# get user input
read -p "Insert the number of the file you want to edit: " FILE_INDEX
# check if input is valid
if [ "$FILE_INDEX" -gt 0 ] && [ "$FILE_INDEX" -le "${#FILE_ARRAY[@]}" ]; then
    FILE_TO_OPEN="${FILE_ARRAY[$((FILE_INDEX-1))]}"
    # check if file is in $XCFG_DIR
    if [ -f "$XCFG_DIR/$FILE_TO_OPEN" ]; then
        echo -e "\nFILE: $FILE_TO_OPEN\nEDITOR: $EDITOR"
        "$EDITOR" "$XCFG_DIR/$FILE_TO_OPEN"
    # check if file is in $DIR
    elif [ -f "$DIR/$FILE_TO_OPEN" ]; then
        echo -e "\nFILE: $FILE_TO_OPEN\nEDITOR: $EDITOR"
        "$EDITOR" "$DIR/$FILE_TO_OPEN"
    else
        echo "ERROR: File not found"
        exit 1
    fi
else
    echo "ERROR: invalid number"
    exit 1
fi
