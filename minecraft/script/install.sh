
INSTALL_001_SERVER_INSTALL=/script/install.001.server.$MC_LOADER.sh
INSTALL_099_GEN_RUN=

if [ ! -f ${INSTALL_001_SERVER_INSTALL} ]; then
    echo Oops. Un-support Minecraft server type $MC_LOADER
    exit -1
fi

${INSTALL_001_SERVER_INSTALL}

MC_LUNCH_JAR=`cat /tmp/MC_LUNCH_JAR`
MC_LUNCH_SH=${MC_HOME}/run.sh

echo "java -Xmx\${MC_MEM_MAX} -Xms\${MC_MEM_MIN} \${MC_JAVA_OPT} -jar ${MC_LUNCH_JAR} nogui" > ${MC_LUNCH_SH}
chmod +x ${MC_LUNCH_SH}

echo ========================= Install Server Done =========================