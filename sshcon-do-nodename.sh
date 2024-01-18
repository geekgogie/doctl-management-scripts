
#!/bin/bash

## use this https://slugs.do-api.dev/

. config-droplets.cfg

node_name=""
misuse=0
verbose=0

getHelp() {
  cat << EOF
    Usage: ./sshcon-do-nodename.sh --nodename <digital_ocean_compute_node_name>

        -db, --nodename                    The digital compute nodename
        -v, --verbose
EOF

}

getNodeName() {
        while [[ $# -gt 0 ]]; do
          case $1 in
            -v|--verbose)
              verbose=1
              ;;
           -db|--nodename)
              # This is a long option
              shift 1
              node_name=$1
              ;;
            *)
              getHelp
              misuse=1
              break
              ;;
          esac
          shift
        done
}

droplet_connect_ssh_node() {
    local ip_to_connect
    echo "Extracing IP address/hostname from compute node named \"${node_name}\"..."
    ip_to_connect=$(./get-droplets.sh | egrep "\s${node_name}\s" |  sed -Ee 's| +|\||g'|cut -d '|' -f 3)

    [[ $? -ne 0 || -z $ip_to_connect ]] && echo "Cannot extract IP/hostname..." && return 0

    echo "Found IP is ${ip_to_connect}..."
    echo "Connecting to IP/host ${ip_to_connect} from ${node_name}..."

    if [[ $verbose -gt 0 ]]; then
       ssh root@${ip_to_connect} -vvv
    else
       ssh root@${ip_to_connect}
    fi
}

getNodeName $@

if [[ -n $node_name && $misuse -eq 0 ]]; then
        droplet_connect_ssh_node
fi

