FROM python:3.14-alpine
ARG ANSIBLE_VERSION=13.1.0
#### Copy required files 
RUN mkdir -p /root/.ssh /etc/ansible /workspace \
    && apk --no-cache add \
    sshpass \
    openssh-client \
    vim \
    nano \
    git \
    tar \
    && pip install --no-cache-dir ansible==$ANSIBLE_VERSION passlib proxmoxer requests \
    && ansible-galaxy collection install community.general

COPY conf/ansible.cfg /etc/ansible/ansible.cfg

WORKDIR /workspace/
