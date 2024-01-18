#!/bin/bash

## use this https://slugs.do-api.dev/

tag_name="paul"

droplet_apply_tags() {
    echo "Getting list of droplets"
    local droplets
    droplets_id=$(cat droplets.txt | cut -d ' ' -f1)
    to_be_removed=$(cat droplets.txt | cut -d ' ' -f1,2,3,15)


    echo ""
    echo "Droplets to be applied with tag name \"${tag_name}\" are the following:"
    echo "${to_be_removed}"
    read -p "You wish to continue? " x

    if [[ ! -z "$x" ]]; then
        if [[ ! -z $droplets_id ]]; then
            echo "Applying tag/s to a droplet one at a time..."
            for droplet in $droplets_id; do
                doctl compute tag apply ${tag_name} --resource do:droplet:${droplet}
                echo "Applied tag name  \"${tag_name}\" to droplet id: ${droplet}"
            done
        else
            echo "No droplets to be applied with tags"
        fi
    else
            echo "Aborted..."
    fi


}

droplet_apply_tags

