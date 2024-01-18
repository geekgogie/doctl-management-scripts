#!/bin/sh


nodename=""

echo "the number of args: " $#

getHelp() {
  cat << EOF
    Usage: ./bb.sh --nodename <digital_ocean_compuete_node_name> 
     
        -db, --nodename                    The digital compuete nodename

EOF

}


while [[ $# -gt 0 ]]; do
  case $1 in
   -db|--nodename)
      # This is a long option
      shift 1
      nodename=$1
      ;;
    *)
      getHelp
      ;;
  esac
  shift
done



echo nodnename=$nodename
