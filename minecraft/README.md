# One Click setup a minecraft server, host by docker

## Support

+ Java Version
    + [x] 8/17/21 support
+ Server
    + [x] Vanilla
    + [x] Fabric
    + [ ] Forge
+ Java Options
    + [x] Xmx
    + [x] Xms
    + [x] Custom by provide environment variable MC_JAR_OPT
+ Mod download
    + [ ] Curseforge
    + [ ] Modrinth

## Environment required

docker with docker-compose

## Setup

1. mkdir 
2. Download docker-compose.yml
3. Edit the docker-compose.yml
    JAVA_VERSION as what you need  
    container_name as anything you like  
    MC_TYPE as which server type you need  
    MC_VERSION as game version you need  
    MC_MEM_MAX the max memory for game  
    MC_MEM_MIN the min memory for game  
    port  
    volume  
4. Exec command `docker compose up -d`  
5. Enjoy the game

## How to manage server

### 1.Exec game command

You should enable the rcon server by set those field in **server.properties**
    enable-rcon=true
    rcon.password=<anything you like>
    rcon.port=25575

then you can exec the command via rcon 

    `docker exec -it minecraft-1.21.1 rcon -H localhost -p <rcon.port> -P <rcon.password> -m`

and now you are in minecraft shell, just type any command you like,
such as 
    `op Zi_Min`
press Ctrl+C exit the minecraft shell
