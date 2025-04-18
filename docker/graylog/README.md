### Graylog Installation Guide

Make sure timezone is set to UTC

```bash
sudo timedatectl set-timezone UTC
```

Create a password to use for admin in docker-compose.xml

```bash
echo -n YourPassword | shasum -a 256
```

Custom message variables used in OpenVPN Slack Notice

```json
${if backlog} ${foreach backlog message} OpenVPN User: ${message.fields.client_username} Logged In via : ${message.fields.client_ip} at ${event.timestamp} ${end} ${end}
```
Custom message variables used for Basic Email notice

```json
Title: ${event_definition_title} Description: ${event_definition_description} Timestamp: ${event.timestamp} Message: ${event.message} ${if backlog} ${foreach backlog message} ${message.message} ${end} ${end} 
```