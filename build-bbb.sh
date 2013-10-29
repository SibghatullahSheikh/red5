#!/bin/bash

set -x

RED5_SRC=$(pwd)
RED5_SERVER=${RED5_SRC}/target/red5-server
RED5_JAR=${RED5_SERVER}/red5-server.jar
RED5_JAR_VER=red5-1.0r4643.jar

RED5_PROD=/usr/share/red5

cd $RED5_SRC

DESKSHARE=/home/firstuser/dev/bigbluebutton/deskshare
VOICE=/home/firstuser/dev/bigbluebutton/bbb-voice
VIDEO=/home/firstuser/dev/bigbluebutton/bbb-video
APPS=/home/firstuser/dev/bigbluebutton/bigbluebutton-apps

echo "Building apps"
cd $APPS
cp $RED5_JAR $APPS/lib/$RED5_JAR_VER
gradle resolveDeps
gradle clean war deploy

echo "Building voice"
cd $VOICE
cp $RED5_JAR $VOICE/lib/$RED5_JAR_VER
gradle resolveDeps
gradle clean war deploy

echo "Building video"
cd $VIDEO
cp $RED5_JAR $VIDEO/lib/$RED5_JAR_VER
gradle resolveDeps
gradle clean war deploy

echo "Building deskshare"
cd $DESKSHARE
cp $RED5_JAR $DESKSHARE/lib/$RED5_JAR_VER
gradle resolveDeps
cd $DESKSHARE/app
gradle clean war deploy

cd $RED5_SRC

sudo chown -R red5.adm $RED5_PROD
sudo chmod -R 777 $RED5_PROD/webapps/

