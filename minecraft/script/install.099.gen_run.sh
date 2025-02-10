
MC_LUNCH_JAR=`cat /tmp/MC_LUNCH_JAR`
MC_LUNCH_SH=${MC_HOME}/run.sh

echo "java -Xmx\${MC_MEM_MAX} -Xms\${MC_MEM_MIN} \${MC_JAVA_OPT} -jar ${MC_LUNCH_JAR} nogui" > ${MC_LUNCH_SH}
chmod +x ${MC_LUNCH_SH}
