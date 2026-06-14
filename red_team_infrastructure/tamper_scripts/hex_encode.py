#!/usr/bin/env python3
"""
Cyber-Stack Tamper Script: Hexadecimal Encoding
Converts all characters in the payload to their hex equivalents.
"""

import binascii

def dependencies():
    pass

def tamper(payload, **kwargs):
    if not payload:
        return payload

    # Convert payload to hex representation (e.g., SELECT -> 0x53454c454354)
    hex_encoded = binascii.hexlify(payload.encode('utf8')).decode('utf8')
    
    # Prepend SQL hex identifier
    return f"0x{hex_encoded}"
