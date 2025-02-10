
MANIFEST_SITE=https://launchermeta.mojang.com/mc/game/version_manifest.json
DOWNLOAD_MIRROR=https://piston-meta.mojang.com # official

META_URL=`curl -s ${MANIFEST_SITE} | jq -r ".versions.[] | select(.id == \"${MC_VERSION}\") | .url"`
META_URL=`echo ${META_URL} | sed "s@https://piston-meta.mojang.com@${DOWNLOAD_MIRROR}@g"`

DOWNLOAD_URL=`curl -s ${META_URL} | jq -r ".downloads.server.url"`
DOWNLOAD_URL=`echo ${DOWNLOAD_URL} | sed "s@https://piston-meta.mojang.com@${DOWNLOAD_MIRROR}@g"`

echo $DOWNLOAD_URL
curl -OJ ${DOWNLOAD_URL}

echo server.jar > /tmp/MC_LUNCH_JAR
