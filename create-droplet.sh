#!/bin/bash

## use this https://slugs.do-api.dev/

. config-droplets.cfg

droplet_create_single() {
    echo "Creating a single droplet..."

	echo ""
	echo "Enter the droplet name you want to create..."
	read -p "Enter droplet name or hit enter to abort... " droplet_name
	
	
	if [[ ! -z "${droplet_name}" ]]; then
		echo "Creating droplet named: ${droplet_name}"
		 doctl compute droplet create --region ${REGION} --image ${IMAGE} --size ${SIZE} --tag-names ${TAG_NAMES} --ssh-keys ${SSH_KEYS} --wait ${droplet_name}
		echo "Droplet named \"${droplet_name}\" created..."
	else
		echo "Action aborted... No droplet created..."
	fi
	
}

droplet_create_single


