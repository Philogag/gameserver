
FABRIC_SITE=https://meta.fabricmc.net

FABRIC_LOADER_VER=`curl -s ${FABRIC_SITE}/v2/versions/loader | jq -r '.[0].version'`
FABRIC_INSTALLER_VER=`curl -s ${FABRIC_SITE}/v2/versions/installer | jq -r '.[0].version'`

DOWNLOAD_URL=${FABRIC_SITE}/v2/versions/loader/${MC_VERSION}/${FABRIC_LOADER_VER}/${FABRIC_INSTALLER_VER}/server/jar

echo ${DOWNLOAD_URL}
curl -OJ ${DOWNLOAD_URL}

ls fabric-server*.jar -1 > /tmp/MC_LUNCH_JAR
