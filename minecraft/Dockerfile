FROM alpine:latest
ARG  JAVA_VERSION

RUN apk add --no-cache \
        tzdata \
        curl \
        jq \
        openjdk$JAVA_VERSION \
	rcon

ADD script /script
RUN chmod +x /script/*.sh

# vanilla # fabric # forge
ENV MC_TYPE=vanilla
ENV MC_VERSION=1.20.1
ENV MC_EULA=true
ENV MC_HOME=/minecraft
ENV MC_MEM_MAX=4G
ENV MC_MEM_MIN=2G
ENV MC_JAR_OPT=

VOLUME /minecraft
WORKDIR /minecraft

CMD "/script/run.sh"
