MASTER_RESOURCES='/opt/sync/Genomics'
if [ ! -d resources ]; then
    mkdir resources
fi
cp -r $MASTER_RESOURCES/ohsu/dnapipeline/bwa-0.7.4 ./resources
sudo docker build -t ccc.docker/bwa -f bwa.dockerfile .
sudo docker push ccc.docker/bwa:latest
