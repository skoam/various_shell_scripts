#!/bin/bash

EASYRSA_EXECUTABLE="/etc/openvpn/easy-rsa/easyrsa"
EASYRSA_EXECUTABLE_BACKUP="$EASYRSA_EXECUTABLE.nostdin.bkp"

# Restore easyrsa to original state or create backup from original
if [ -f "$EASYRSA_EXECUTABLE_BACKUP" ]; then
	cp $EASYRSA_EXECUTABLE_BACKUP $EASYRSA_EXECUTABLE
else
	cp $EASYRSA_EXECUTABLE $EASYRSA_EXECUTABLE_BACKUP
fi

# Get Line Number of gen_req() {
GEN_REQ_LOCATION=$(cat $EASYRSA_EXECUTABLE | grep -n "gen_req() {" | awk "NR==1" | awk -F ':' '{print $1}')
# Get Line Number of first opts= after gen_req() {
OPTS_LOCATION=$(tail $EASYRSA_EXECUTABLE -n +$GEN_REQ_LOCATION | grep -n "opts=\"" | awk "NR==1" | awk -F ':' '{print $1}')

# Add Numbers to get global position of matched opts= statement 
COMBINED_LOCATION=$(($GEN_REQ_LOCATION+$OPTS_LOCATION-1))

# Add -passout stdin to opts=
RESULT=$(cat $EASYRSA_EXECUTABLE | sed -e "${COMBINED_LOCATION}s/.*opts=\"/\topts=\"-passout stdin /")

# Overwrite original easyrsa
echo "$RESULT" > $EASYRSA_EXECUTABLE

exit 0
