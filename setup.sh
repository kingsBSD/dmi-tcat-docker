#!/bin/bash
key=""
keysecret=""
token=""
tokensecret=""
exec 3>&1
VALUES=$(dialog --ok-label "Submit" \
          --backtitle "TCAT Twitter Settings" \
          --title "DMI-TCAT-DOCKER SETUP" \
          --form "Enter your Twitter app credentials:" \
        11 80 0 \
        "Consumer Key:" 1 1 "$key"         1 17 30 0 \
        "Consumer Secret:"    2 1 "$keysecret"        2 17 55 0 \
        "User Token:"    3 1 "$token"       3 17 55 0 \
        "User Secret:"     4 1 "$tokensecret"         4 17 55 0 \
2>&1 1>&3)
exec 3>&-
ARR=($VALUES)
key=${ARR[0]}
keysecret=${ARR[1]}
token=${ARR[2]}
tokensecret=${ARR[3]}
if [ ! -z "$key" ] && [ ! -z "$keysecret" ] && [ ! -z "$token" ] && [ ! -z "$tokensecret" ]; then
cp run_template run.sh
sed -i "s#CONSUMERKEY#$key#" run.sh
sed -i "s#CONSUMERSECRET#$keysecret#" run.sh
sed -i "s#USERTOKEN#$token#" run.sh
sed -i "s#USERSECRET#$tokensecret#" run.sh
fi
