### 1. Make the script executable:

```bash
chmod +x plex-claim-server.sh
```

### 2. Get your Plex Claim Code (it's only valid some minutes): https://www.plex.tv/claim/

### 3. Claim your server:

 ```bash
 sudo -u plex ./plex-claim-server.sh "$YOUR_CLAIM_CODE"

 ```

### 4. Restart your Plex Media Server, e.g. with sudo systemctl restart plexmediaserver