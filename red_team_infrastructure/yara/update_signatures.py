#!/usr/bin/env python3
import urllib.request
import os

# Example source: a public or private threat intel repository
SIG_URL = "https://raw.githubusercontent.com/Yara-Rules/rules/master/malware/MALW_Misc.yar"

def update_yara_rules():
    save_path = os.path.join(os.path.dirname(__file__), "external_intel.yar")
    print(f"[*] Fetching updated YARA signatures from {SIG_URL}...")
    
    try:
        urllib.request.urlretrieve(SIG_URL, save_path)
        print(f"[+] Successfully updated signatures: {save_path}")
    except Exception as e:
        print(f"[-] Failed to update YARA rules: {e}")

if __name__ == "__main__":
    update_yara_rules()
