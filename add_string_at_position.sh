#!/bin/bash
# USAGE: ./add_string_at_position -i "Test Input String" -p 12 -f /path/to/file.txt

while [ "$1" != "" ]; do
  case $1 in
    -i | --input )            shift
                              INPUT_STRING="$1"
                              ;;
    -p | --position )         shift
                              POSITION="$1"
                              ;;
    -f | --file )             shift
                              FILE_NAME="$1"
                              ;;
  esac
  shift
done

if [ -z "$INPUT_STRING" ] || [ -z "$POSITION" ] || [ -z "$FILE_NAME" ]; then
  echo "Please provide -i 'input_string', -p {line_number} and -f 'file_name'"
  exit 1
fi

RESULT=$(cat $FILE_NAME | sed -e "${POSITION}i${INPUT_STRING}")
echo "$RESULT" > $FILE_NAME

exit 0
