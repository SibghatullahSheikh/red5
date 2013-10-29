#!/bin/bash

set -x

RED5_SRC=$(pwd)
RED5_TARGET=$RED5_SRC/target/red5-server
RED5_PROD=/usr/share/red5-r4729
RED5_LN=/usr/share/red5


if [ -d $RED5_PROD ]; then
  echo "deleting ${RED5_PROD}"
  sudo rm -rf $RED5_PROD
fi

sudo cp -R $RED5_TARGET $RED5_PROD

sudo rm $RED5_LN
sudo ln -s $RED5_PROD $RED5_LN
sudo chown -R red5.adm $RED5_PROD
sudo chmod -R 777 $RED5_LN/webapps/

