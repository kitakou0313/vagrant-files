#!/bin/bash

# Install containerd + nerdctl
wget https://github.com/containerd/nerdctl/releases/download/v1.7.5/nerdctl-full-1.7.5-linux-amd64.tar.gz
tar Cxzvvf /usr/local nerdctl-full-1.7.5-linux-amd64.tar.gz

# edit /etc/sudoers
sed -i 's/Defaults[[:space:]]\+secure_path/# &/' /etc/sudoers
echo 'Defaults    env_keep += "PATH"' >> /etc/sudoers
