if [ ! -f ${MC_HOME}/run.sh ]; then
    /script/install.sh
    if [ $? -ne 0 ]; then 
        exit $?
    fi
fi

echo eula=${MC_EULA} > ${MC_HOME}/eula.txt

/bin/sh -x ${MC_HOME}/run.sh