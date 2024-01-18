#!/bin/bash

## use this https://slugs.do-api.dev/

number_of_droplets=6
droplet_pref="dbnode"

droplet_create_multi() {
    echo "Create multiple ${number_of_droplets} droplets..."
	
    increment=1
    increment_name=17
    echo "Creating droplet: $droplets"
    while [[ $increment -le ${number_of_droplets} ]]; do
		droplet_name="${droplet_pref}${increment_name}"
		echo "Creating droplet named: ${droplet_name}"
		 doctl compute droplet create --region sgp1 --image ubuntu-20-04-x64 --size s-1vcpu-2gb --tag-names "paul_unibank_training,db_nodes" --ssh-keys "4d:28:b2:fe:6d:b0:cb:53:86:ab:f7:be:a1:cf:66:5d" --wait ${droplet_name}
		
        increment=$((increment+1))
        increment_name=$((increment_name+1))
    done
	
}

droplet_create_multi


