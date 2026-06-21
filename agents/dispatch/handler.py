#!/usr/bin/env python3
import sys
import json

def main():
    # Read input (the load request data) from stdin
    data = sys.stdin.read()
    try:
        payload = json.loads(data) if data.strip() else {}
    except:
        payload = {"raw": data}
    
    message = {
        "status": "unavailable",
        "message": "Dispatch agent not yet implemented. Here is your load request data:",
        "data": payload
    }
    print(json.dumps(message, indent=2))

if __name__ == "__main__":
    main()
