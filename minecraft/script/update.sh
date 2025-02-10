

if [ x$MC_LOADER != xvanilla ]; then
    if [ -n $MC_MOD_MODRINTH ]; then 
        /script/update.mods.modrinth.sh
    fi

    echo ========================= Install Mods Done =========================
fi

# EULA
echo eula=${MC_EULA} > ${MC_HOME}/eula.txt
