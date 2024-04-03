#!/bin/bash

# Install containerd + nerdctl
wget https://github.com/containerd/nerdctl/releases/download/v1.7.5/nerdctl-full-1.7.5-linux-amd64.tar.gz
tar Cxzvvf /usr/local nerdctl-full-1.7.5-linux-amd64.tar.gz

# edit /etc/sudoers
sed -i 's/Defaults[[:space:]]\+secure_path/# &/' /etc/sudoers
echo 'Defaults    env_keep += "PATH"' >> /etc/sudoers

# create user for ssh
useradd -m -s /bin/bash test
echo "test:test" | sudo chpasswd
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

echo "test ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

systemctl restart sshd
systemctl enable containerd
