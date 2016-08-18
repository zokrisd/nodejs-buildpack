#!/usr/bin/env bash

MY_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $MY_PATH/../../json.sh

VCAP_SERVICES_NEW_RELIC_LICENSE_KEY=$(echo $VCAP_SERVICES | $JQ --raw-output .newrelic[0].credentials.licenseKey)

if [ ! -z "$VCAP_SERVICES_NEW_RELIC_LICENSE_KEY" ];
then
  export NEW_RELIC_LICENSE_KEY=$VCAP_SERVICES_NEW_RELIC_LICENSE_KEY
fi

