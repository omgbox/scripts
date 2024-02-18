#! /bin/bash
#caddy reverse-proxy --from youtube.com www.youtube.com --to localhost:3000
# use pm2 to start this bash script
caddy run --config /etc/caddy/Caddyfile


-------------------------------------------------------------

MAKE FILE WITH NANO
nano /etc/caddy/Caddyfile

copy inside 
--------------------------------------------
domain.ovh {
    reverse_proxy localhost:3000 
    # tell Caddy to reverse proxy that port to your subdomain
}
www.rsd.ovh {
  redir https://domain.ovh{uri} permanent
}
http://www.domain.ovh {
  redir https://domain.ovh{uri} permanent
}
https://www.domain.ovh {
  redir https://domain.ovh{uri} permanent
}
