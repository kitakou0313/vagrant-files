#!/bin/bash

# Install my dot file
wget https://raw.githubusercontent.com/kitakou0313/dotfiles/main/installer.sh
/bin/bash installer.sh

# Install containerd + nerdctl
wget https://github.com/containerd/nerdctl/releases/download/v1.7.5/nerdctl-full-1.7.5-linux-amd64.tar.gz
tar Cxzvvf /usr/local nerdctl-full-1.7.5-linux-amd64.tar.gz

# edit /etc/sudoers
sed -i 's/Defaults[[:space:]]\+secure_path/# &/' /etc/sudoers
echo 'Defaults    env_keep += "PATH"' >> /etc/sudoers
echo "test ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

# create user for ssh
useradd -m -s /bin/bash test
echo "test:test" | sudo chpasswd
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

systemctl enable containerd

systemctl restart containerd
systemctl restart sshd
