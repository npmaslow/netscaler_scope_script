#!/bin/bash

# Check if a file name is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

filename="$1"

# Check if the file exists
if [ ! -f "$filename" ]; then
  echo "Error: File '$filename' not found."
  exit 1
fi

echo "LB VS Parse for '$filename':"
echo "-------------------------------------"

# Use wc to count lines, words, and characters
# wc "$filename"
lbcount=$(more $filename | grep -i "add lb vs" | wc -l)
echo "$lbcount"

echo "CS VS Parse for '$filename':"
echo "-------------------------------------"

# Use wc to count lines, words, and characters
cscount=$(more $filename | grep -i "add cs vs" | wc -l)
echo "$cscount"


echo "Conversion Scope Ballpark in Minutes for '$filename':"
echo "-------------------------------------"

basictime=$(($lbcount*5 + $cscount*30))
echo "$basictime"

echo "More details on Content Switching for '$filename' - if there are on average more than 10 policies of any type per cs vs, add time:"
echo "-------------------------------------"
cspolcount=$(more $filename | grep -i "add cs policy" | wc -l)
echo "There are '$cspolcount' content switch policies"
csrwcount=$(more $filename | grep -i "add rewrite action" | wc -l)
echo "There are '$csrwcount' rewrite policies"
csrescount=$(more $filename | grep -i "add responder action" | wc -l)
echo "There are '$csrescount' responder actions"
cstpcount=$(more $filename | grep -i "add transform profile" | wc -l)
echo "There are '$cstpcount' responder actions"
cstacount=$(more $filename | grep -i "add transform action" | wc -l)
echo "There are '$cstacount' responder actions"

echo "Does '$filename' contain Citrix L3 mode? If so, review the need for forwarding virtual servers on Pool Member VLANs:"
echo "-------------------------------------"

nsmodes=$(more $filename | grep -i "enable ns mode" )
l3mode=L3

if [[ "$nsmodes" == *"$l3mode"* ]]; then
  echo "L3 mode is present"
else
  echo "L3 mode is NOT present"
fi

echo "Does '$filename' contain any modules that need to be manually scoped?:"
echo "-------------------------------------"
vpnvscount=$(more $filename | grep -i "add vpn vs" | wc -l)
echo "There are '$vpnvscount' SSL VPN virtual servers to scope as APM policies"
dnsvscount=$(more $filename | grep -i "add dns vs" | wc -l)
echo "There are '$dnsvscount' DNS virtual servers to scope as GSLB/DNS migration"
aaavscount=$(more $filename | grep -i "add aaa vs" | wc -l)
echo "There are '$aaavscount' AAA virtual servers to scope as APM SSO/2FA configurations"
crvscount=$(more $filename | grep -i "add cr vs" | wc -l)
echo "There are '$crvscount' cache redirection virtual servers to scope as HTTP caching policies below"
crpolcount=$(more $filename | grep -i "add cache policy" | wc -l)
echo "There are '$crpolcount' cache policies to review and scope"