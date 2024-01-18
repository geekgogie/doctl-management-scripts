#!/bin/bash

## use this https://slugs.do-api.dev/
. config-droplets.cfg
filter=${FILTER}
filter2=".*"

droplet_delete_single() {
    echo "Getting list of droplets..."
    local droplets 
	droplets=$(doctl compute droplet list --format="ID,Name,PublicIPv4,PrivateIPv4,Tags,Memory,VCPUs"|egrep "IPv4|${filter}"|egrep "IPv4|${filter2}")
	cat <<eof | sed -Ee 's| +| |g'
${droplets}
eof

	echo ""
	echo "Enter the droplet you want to remove using droplet-id"
	read -p "Type the dropliet ID here: " droplet_id
	
	if [[ ! -z "${droplet_id}" ]]; then
	    echo "Getting information of droplet: ${droplet_id}"
	    droplet_info=$(doctl compute droplet get --format="ID,Name,PublicIPv4,PrivateIPv4,Tags,Memory,VCPUs" ${droplet_id})
		if [[ $? -eq 0 ]]; then

				cat<<eof
${droplet_info}
eof
				echo "Is droplet correct?"
				read -p "If you wish to continue, answer \"yes/y\" hit enter or other keys to abort..." y
		
		
				if [[ -n "${y}" && "${y}" =~ ^([yY][eE][sS]|[yY])$ ]]; then
					echo "Deleting droplet id: ${droplet_id}"
					doctl compute droplet delete -v --interactive -f ${droplet_id}
		        	        echo "Deleted droplet: ${droplet_id}"
				else
					echo "Aborted....not proceeding to delete droplet..."
				fi
		
		else
			echo "Droplet id not found...Aborting..."
		fi
	else
		echo "Droplet empty or action aborted..."
	fi
	
	
}

droplet_delete_single


