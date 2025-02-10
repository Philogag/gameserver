docker build . --build-arg JAVA_VERSION=$1 --tag $2
docker push $2