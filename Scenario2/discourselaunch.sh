curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get -y update
apt-get install -y docker-ce
sudo usermod -aG docker ubuntu
mkdir /var/discourse
git clone https://github.com/discourse/discourse_docker.git /var/discourse
