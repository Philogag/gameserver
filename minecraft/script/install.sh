
INSTALL_001_SERVER_INSTALL=/script/install.001.server.$MC_TYPE.sh
INSTALL_099_GEN_RUN=/script/install.099.gen_run.sh

if [ ! -f ${INSTALL_001_SERVER_INSTALL} ]; then
    echo Oops. Un-support Minecraft server type $MC_TYPE
    exit -1
fi

${INSTALL_001_SERVER_INSTALL}
${INSTALL_099_GEN_RUN}

echo ========================= Install Finish =========================