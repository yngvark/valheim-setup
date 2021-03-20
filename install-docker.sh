sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Install

sudo apt-get -y update

sudo apt-get install -y docker-ce

# Post install

# sudo groupadd docker

sudo usermod -aG docker $USER
sudo systemctl daemon-reload
sudo systemctl restart docker


# CUSTOMIZATION: Change image default location
# Taken from: https://stackoverflow.com/questions/24309526/how-to-change-the-docker-image-installation-directory

# sudo mkdir -p /etc/systemd/system/docker.service.d
# 
# DOCKER_STORAGE_FILE=/etc/systemd/system/docker.service.d/docker_storage.conf
# cp docker_storage.conf.template docker_storage.conf
# sed -i "s@#REPLACE_DOCKER_IMAGES_DIR_FULL#@$DOCKER_IMAGES_DIR_FULL@" docker_storage.conf
# sudo mv docker_storage.conf /etc/systemd/system/docker.service.d
# 
# sudo systemctl daemon-reload
# sudo systemctl restart docker

# Verify installation

echo To verify installation: Log out and in, and run
echo docker run hello-world
echo 
echo Actually I think you must relogin to run docker without sudo.
