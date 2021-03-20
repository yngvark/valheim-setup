# Create server

I'm using cloud provider Hetzner, which has a firewall in their web interface.

Using Ubuntu 20.04.

* Add ports to Hetzner firewall
    * Valheim portsgoogle Valheim ports)
    * SSH port 22
    * HTTP and test HTTP, 80 (for valheim dashboard) and 8080 (for helloworld testing)
* ssh into server

```sh
apt update -y
apt upgrade -y

# Add user
adduser myself
usermod -aG sudo myself
su myself
```

sudo systemctl restart docker

* Secure stuff: https://askubuntu.com/a/346863/575647
  * In `/etc/ssh/sshd_config`, change to 

```
PasswordAuthentication no
PubkeyAuthentication yes
```

```
systemctl restart sshd.service
```

# Clone this repository

```sh
su myself
git clone https://github.com/yngvark/valheim-setup.git
git checkout main
```


# Install Docker

```sh
./install-docker.sh
```

Log out of the shell, log in again.

```sh
docker run -d -p 8080:80/tcp "karthequian/helloworld:latest"
```

Go to the URL of your server on port 8080, and verify that you get a hello world page.

# Set up Valheim server backup

## Install Rclone

* Create a Jottacloud account, or some other cloud storage provider.
* Install Rclone on your server

```
# https://rclone.org/install/
./install-rclone.sh
```

* Configure Rclone (https://rclone.org/jottacloud/)

```sh
rclone config create jotta jottacloud
```

See [rclone-install-log.txt](rclone-install-log.txt) for inputs.

Verify installation with

```sh
touch hello
rclone copy hello jotta:/
```

Visit https://www.jottacloud.com/web/archive/list/name and see that the file is there (file is under
"Archive, not "Synched").

## Setup automatic cron backup

```sh
./setup-valheim-backup.sh ~/valheim-server/config/backups
```


# Setup Valheim
See https://github.com/lloesche/valheim-server-docker#basic-docker-usage



```sh
mkdir -p $HOME/valheim-server/config/worlds $HOME/valheim-server/data
```

1. Copy run.sh from this repo to server, and `chmod +x run.sh`
2. Edit secret
3. Run:

```sh
./run.sh
```
