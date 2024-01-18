#!/bin/bash

## use this https://slugs.do-api.dev/


. config-droplets.cfg
. config-create-droplets.cfg

droplet_create_multi() {
    echo "Create multiple number of droplets..."

    increment=1
        increment_name=$START_OF_INCREMENT

    echo "Creating a total of ${NUMBER_OF_DROPLETS}..."
    while [[ $increment -le ${NUMBER_OF_DROPLETS} ]]; do
        droplet_name="${DROPLET_PREFIX_NAME}${increment_name}"

		echo "Identify if droplet name is already used or not ..."
		ip_to_connect=$(./get-droplets.sh | egrep "\s${droplet_name}\s" |  sed -Ee 's| +|\||g'|cut -d '|' -f 3)

        [[ $? -ne 0 || -n $ip_to_connect ]] && echo "Cannot use droplet name. Droplet name and prefix i.e. \"${droplet_name}\" is already used. Moving to the next droplet name to use and see if its available..." &&  increment=$((increment+1)) &&  increment_name=$((increment_name+1)) && continue

        echo "Will create droplet named: ${droplet_name}"
                doctl compute droplet create --region ${REGION} --image ${IMAGE} --size ${SIZE} --tag-names ${TAG_NAMES} --ssh-keys ${SSH_KEYS} --wait ${droplet_name}
        echo "Droplet named \"${droplet_name}\" created..."
        increment=$((increment+1))
        increment_name=$((increment_name+1))
    done

}

droplet_create_multi

