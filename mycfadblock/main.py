import os

try:
    token = os.environ['CF_API_TOKEN'] = "d94e53c1e384441280fd43cacb3d0f731de6e"
    email = os.environ['CF_API_EMAIL'] = "lucasepcosta@hotmail.com"
    account_id = os.environ['CF_API_ACCOUNT_ID'] = "b26ebcafe492f00c2708d25713a5c728"
except KeyError:
    print('CF_API_TOKEN, CF_API_EMAIL or CF_API_ACCOUNT_ID environment variable not set')

import CloudFlare
import requests
from delete import *
from create import *

def GetBlockList(block_list_url):
    with open(block_list_url, 'r') as file:
        block_list = file.read().splitlines()
    return block_list

def main():
    CF = CloudFlare.CloudFlare(email=email, token=token)

    block_list = GetBlockList("merged_files.csv")
    print("Block list has {} domains".format(len(block_list)))

    DeleteAll(CF)
    CreateAll(CF, block_list)

if __name__ == '__main__':
    main()
