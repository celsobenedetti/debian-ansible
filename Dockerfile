# Dockerfile for testing the playbooks
FROM ubuntu:latest

# Install SSH
RUN apt-get update && \
    apt-get install -y sudo curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Ansible
RUN pip install ansible

WORKDIR /home/app

# Create a new user
RUN useradd -m -s /bin/bash ansible && \
    echo 'ansible:ansible' | chpasswd && \
    usermod -aG sudo ansible

# Give the user ownership of home
RUN chown -R ansible:ansible /home/ansible/

CMD ["bash"]
