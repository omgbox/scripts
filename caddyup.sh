#! /bin/bash
#caddy reverse-proxy --from youtube.com www.youtube.com --to localhost:3000
# use pm2 to start this bash script
caddy run --config /etc/caddy/Caddyfile
