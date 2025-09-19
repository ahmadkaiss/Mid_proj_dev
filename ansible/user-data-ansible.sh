#!/bin/bash
set -euo pipefail
# enable universe, update & install ansible and deps
add-apt-repository -y universe
apt-get update -y
apt-get install -y software-properties-common
apt-get install -y ansible python3 python3-pip python3-venv git curl

mkdir -p /etc/ansible

cat > /etc/ansible/hosts <<'EOF'
[app]
10.10.2.10
10.10.3.10

[app:vars]
ansible_user=ubuntu
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_private_key_file=/home/ubuntu/KP.pem

[all:vars]
ansible_ssh_common_args=-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null
EOF

cat > /etc/ansible/ansible.cfg <<'EOF'
[defaults]
inventory = /etc/ansible/hosts
host_key_checking = False
retry_files_enabled = False
EOF

chown -R ubuntu:ubuntu /etc/ansible || true
mkdir -p /home/ubuntu/ansible-playbooks
chown ubuntu:ubuntu /home/ubuntu/ansible-playbooks || true
echo "Ansible bootstrap finished" > /var/log/ansible_bootstrap.log
