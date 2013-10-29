#!/bin/bash

set -x

RED5_SRC=$(pwd)
RED5_SERVER=${RED5_SRC}/target/red5-server

cd $RED5_SRC

DESKSHARE=/home/firstuser/dev/source/bigbluebutton/deskshare
VOICE=/home/firstuser/dev/source/bigbluebutton/bbb-voice
VIDEO=/home/firstuser/dev/source/bigbluebutton/bbb-video
APPS=/home/firstuser/dev/source/bigbluebutton/bigbluebutton-apps

echo "Building apps"
cd $APPS
gradle resolveDeps
gradle clean war deploy

echo "Building voice"
cd $VOICE
gradle resolveDeps
gradle clean war deploy

echo "Building video"
cd $VIDEO
gradle resolveDeps
gradle clean war deploy

echo "Building deskshare"
cd $DESKSHARE
gradle resolveDeps
cd $DESKSHARE/app
gradle clean war deploy

cd $RED5_SRC

sudo chown -R red5.adm $RED5_DIR
sudo chown -R red5.adm $NEW_RED5
sudo chmod -R 777 $NEW_RED5/webapps/

