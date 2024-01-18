#!/bin/bash

## use this https://slugs.do-api.dev/

. config-droplets.cfg

filter="paul"
filter2=".*"

droplet_get_multi() {
    echo "Getting list of droplets..."
    local droplets 
    ## droplets=$(doctl compute droplet list|grep "paul_unibank_training"|grep "ubuntu-s-2vcpu")
	#droplets=$(doctl compute droplet list|egrep "${filter}"|egrep "${filter2}")
	droplets=$(doctl compute droplet list  --format=${FORMAT} | egrep "IPv4|${filter}"|egrep "IPv4|${filter2}")
	cat <<eof |  sed -Ee 's| +|\||g'| column -c 10 -s "|" -t
${droplets}
eof
}

droplet_get_multi


