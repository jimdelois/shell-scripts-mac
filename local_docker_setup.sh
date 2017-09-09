echo "Creating Docker Machine \"Local\""
docker-machine create -d vmwarefusion --vmwarefusion-cpu-count=4 --vmwarefusion-disk-size=64000 --vmwarefusion-memory-size=6144 local

echo "Setting Up Docker Machine NFS"
docker-machine-nfs local

echo "Attempting a Docker Login:"
docker login