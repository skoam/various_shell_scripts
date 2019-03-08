#!/bin/bash
# A way to parse given arguments without shift, keeping the ARGS list intact
# This can be very useful if used in an entrypoint that is sourced in multiple bash scripts,
# catching globally used arguments first and parsing local arguments later.

ARGS=("$@")
for ((arguments_index=0; arguments_index < $#; arguments_index++)); do
  ARG=${ARGS[$arguments_index]}
  ARG_VALUE=${ARGS[$arguments_index + 1]}
  case $ARG in
    --target )
                              TARGET=$ARG_VALUE
                              ;;
    --file )
                              FILE_NAME=$ARG_VALUE
                              ;;
    --verbose )
                              VERBOSE=$ARG_VALUE
                              ;;
  esac
done
