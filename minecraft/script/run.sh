if [ ! -f ${MC_HOME}/run.sh ]; then
    /script/install.sh
    if [ $? -ne 0 ]; then 
        exit $?
    fi
fi

/script/update.sh

/bin/sh -x ${MC_HOME}/run.sh