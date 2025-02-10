
# MC_HOME=../test/data
# MC_LOADER=fabric
# MC_VERSION=1.21.4
# MC_MOD_MODRINTH=carpetskyadditions-reborn,gca,carpet-tis-addition,no-chat-reports,tweakeroo

DIR_MODS=${MC_HOME}/mods
DIR_MODS_INDEX=${MC_HOME}/mods/.index

CURL=curl --user-agent "philogag/gameserver/1.0.0"

if [ ! -d ${DIR_MODS_INDEX} ]; then
    mkdir -p ${DIR_MODS_INDEX}
fi

function fetch_metadata() {
    FETCH_ID=$1

    ls ${DIR_MODS_INDEX} | grep -F ".$FETCH_ID."
    if [ $? -eq 0 ]; then
        return # exist
    fi

    TMP_FILE=${DIR_MODS_INDEX}/_.json
    ${CURL} -s -G https://api.modrinth.com/v2/project/${FETCH_ID} > ${TMP_FILE}

    PJID=`cat ${TMP_FILE} | jq -r '.id'`
    SLUG=`cat ${TMP_FILE} | jq -r '.slug'`
    SERVER_NEED=`cat ${TMP_FILE} | jq -r '.server_side'`

    echo Fetch modrinth.${SLUG}.${PJID}.${SERVER_NEED}.json

    ${CURL} -s -G \
        --data-urlencode "loaders=[\"${MC_LOADER}\"]" \
        --data-urlencode "game_versions=[\"${MC_VERSION}\"]" \
        https://api.modrinth.com/v2/project/${PJID}/version > ${TMP_FILE}

    CNT=`cat ${TMP_FILE} | jq -r '.|length'`
    if [ $CNT -gt 0 ]; then
        META_FILE=${MC_HOME}/mods/.index/modrinth.${SLUG}.${PJID}.${SERVER_NEED}.json
        cat ${TMP_FILE} | jq '.[0]' > ${META_FILE}
    else
        echo Oops, $SLUG for $MC_LOADER $MC_VERSION not found
        exit -1
    fi

    if [ -f ${TMP_FILE} ]; then 
        rm ${TMP_FILE}
    fi
}

function fetch_all {
    echo ============ Check Metadata ============
    IFS=',' read -ra ITEMS <<< "$1"
    for item in "${ITEMS[@]}"; do
        fetch_metadata $item
    done
    echo Done.
}

function solve_dependence {
    echo ============ Solve Dependence ============
    CHECK_AGAIN=1
    while [ $CHECK_AGAIN -eq 1 ]
    do
        CHECK_AGAIN=0
        for file in `ls -1 ${DIR_MODS_INDEX} | grep -E '^modrinth'`
        do 
            echo Check $file
            for DEP_ID in `cat ${DIR_MODS_INDEX}/$file | jq -r '.dependencies.[].project_id'`
            do
                echo "   - check requirement $DEP_ID"
                ls ${DIR_MODS_INDEX} | grep -F ".${DEP_ID}." > /dev/null
                if [ $? -ne 0 ]; then
                    fetch_metadata ${DEP_ID}
                    CHECK_AGAIN=1
                fi
            done
        done
    done
    echo Done.
}

function download {
    echo ============ Download ============
    for file in `ls -1 ${DIR_MODS_INDEX} | grep -E '^modrinth' | grep  -v -F '.unsupported.'`
    do 
        FILE=`cat ${DIR_MODS_INDEX}/${file} | jq -r '.files[0].filename'`
        URL=`cat ${DIR_MODS_INDEX}/${file} | jq -r '.files[0].url'`
        if [ ! -f ${DIR_MODS}/${FILE} ]; then
            echo "Download ${FILE} => ${URL}"
            ${CURL} -s $URL -o ${DIR_MODS}/$FILE
        else
            echo "${FILE} exist."
        fi
    done
    echo Done.
}

fetch_all ${MC_MOD_MODRINTH}
solve_dependence
download
