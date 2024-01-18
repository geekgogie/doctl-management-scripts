#!/bin/bash

## use this https://slugs.do-api.dev/

droplet_delete_multi() {
    echo "Getting list of droplets"
    local droplets 
    ## droplets=$(doctl compute droplet list|grep "paul_unibank_training"|grep "ubuntu-s-2vcpu")
	##  cat droplets.txt | sed -Ee 's| +| |g'|cut -d ' ' -f1,2,3,15
	droplets_id=$(cat droplets.txt | cut -d ' ' -f1)
	to_be_removed=$(cat droplets.txt | cut -d ' ' -f1,2,3,15)


	echo ""
	echo "Droplets to be removed are..."
	echo "${to_be_removed}"
	read -p "You wish to continue? " x
	
	if [[ ! -z "$x" ]]; then
		if [[ ! -z $droplets_id ]]; then
		    echo "Deleting droplet: $droplets"
		    for droplet in $droplets_id; do
				doctl compute droplet delete -f $droplet
		        echo "Deleted droplet: $droplet"
		    done
		else
			echo "No droplets to be deleted"
		fi
	else
		echo "Aborted..."
	fi
	
	
}

droplet_delete_multi


