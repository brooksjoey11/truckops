#!/usr/bin/env python3
import sys
import json

def main():
    data = sys.stdin.read()
    try:
        payload = json.loads(data) if data.strip() else {}
    except:
        payload = {"raw": data}
    
    message = {
        "status": "unavailable",
        "message": "Compliance check not active. Please manually verify documents for now.",
        "data": payload
    }
    print(json.dumps(message, indent=2))

if __name__ == "__main__":
    main()
