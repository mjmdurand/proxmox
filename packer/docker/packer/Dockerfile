ARG PACKER_VERSION=1.14.3

FROM hashicorp/packer:$PACKER_VERSION

ARG ANSIBLE_VERSION=13.1.0 \
    USER_ID=1001 \
    GROUP_ID=1001

RUN apk update \
    && apk add --no-cache python3 py3-pip openssh tar unzip \
    #### Fix "externally-managed-environment" error
    && rm /usr/lib/python3.*/EXTERNALLY-MANAGED \
    && pip3 install pip --upgrade \
    && pip3 install ansible==$ANSIBLE_VERSION \
    && adduser -u $USER_ID -g $GROUP_ID -D user

USER user

WORKDIR /workspace