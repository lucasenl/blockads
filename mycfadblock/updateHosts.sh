#!/bin/bash

# Declare file URLs
file1_url="https://raw.githubusercontent.com/badmojr/1Hosts/master/Lite/hosts.txt"
file2_url="https://raw.githubusercontent.com/sjhgvr/oisd/main/hosts_basic.txt"
file3_url="https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt"
file4_url="https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardDNS.txt"
file5_url="https://raw.githubusercontent.com/hagezi/dns-blocklists/main/hosts/doh-vpn-proxy-bypass.txt"

# Download files using curl
curl --silent $file1_url | python hosts2csv.py > file1.csv && \
curl --silent $file2_url | python hosts2csv.py > file2.csv && \
curl --silent $file3_url | python hosts2csv.py > file3.csv && \
curl --silent $file4_url | python hosts2csv.py > file4.csv && \
curl --silent $file5_url | python hosts2csv.py > file5.csv && \

# Merge files and remove duplicate wildcard domains
cat file1.csv file2.csv file3.csv file4.csv file5.csv \
| grep -vE "0.0.0.0|mullvad|cloudflare-gateway" | sort -u > merged_files.csv

# Remove temporary files
rm file1.csv file2.csv file3.csv file4.csv file5.csv

python main.py
