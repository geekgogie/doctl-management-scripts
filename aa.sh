#/!bin/bash

# Fetch getopt version
getopt --test > /dev/null 

# If returns 4 parse with getopt
# Otherwise means it's a version we don't like
echo "the ? is: " $?
if [[ $? -ne 4 ]]; then
  printf "warning: \`getopt --test\` did not return 4...\ndefaulting to std handling...\n"
else
  # A colon after the option means an additional arg is expected
  _longopts="src:,dest:,config:,delete,update,interactive,verbose,version,help"
  _options="s:d:f:DuIvVh"

  # Parse command line arguments using getopt
  PARSED=$(getopt --options=$_options --longoptions=$_longopts --name "$0" -- "$@")
  if [[ $? -ne 0 ]]; then
    exit 1
  else
    # Set getopt output
    eval set -- "$PARSED"
  fi
fi

# Parse command arguments
while [[ $# -gt 0 ]]; do
  # Shift makes you parse next argument as $1.
  # Shift n makes you move n arguments ahead.
  case $1 in
    -s|--src)
      # Remove any amount of trailing slashes
      _trimmed_s="${2%%+(/)}"
      # Source files
      IFS=' ' read -r -a sources <<< "$_trimmed_s"
      shift 2
      ;;
    -d|--dest)
      # Remove any amount of trailing slashes
      _trimmed_d="${2%%+(/)}"
      # Destination path
      IFS=' ' read -r -a destination <<< "$_trimmed_d"
      shift 2
      ;;
    -f|--config)
      IFS=' ' read -r -a config_file <<< "$2"
      shift 2
      ;;
    -D|--delete)
      # Delete files
      delete=1
      shift
      ;;
    -u|--update)
      # Update files
      update=1
      shift
      ;;
    -I|--interactive)
      # Prompt user for actions
      interactive=1
      shift
      ;;
    -v|--verbose)
      # Print more stuff
      let verbose++
      shift
      ;;
    -V|--version)
      # Print version number
      echo 0.000000001
      shift
      ;;
    -h|--help)
      # Print help
      echo huh... sorry.
      shift
      ;;
    --)
      shift
      break
      ;;
    -*|--*)
      echo "${0}: invalid option -- '${1}'"
      exit 1
      ;;
    *)
      positional_args+=("$1") # Save positional args
      shift
      ;;
  esac
done

# If getopt wasn't used
if [ -z "$_options" ]; then
  # Restore positional arguments
  set -- "${positional_args[@]}"
fi

# Free arguments are now set as $@ 
# Can be accessed later on
