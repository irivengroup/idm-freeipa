FROM rockylinux:9

ENV container=docker

RUN dnf -y install dnf-plugins-core && \
    (dnf config-manager --set-enabled crb || true) && \
    dnf -y clean all && \
    dnf -y makecache && \
    dnf -y install --allowerasing \
      ipa-client \
      openssh-server \
      openssh-clients \
      sudo \
      sssd \
      oddjob \
      oddjob-mkhomedir \
      authselect \
      krb5-workstation \
      procps-ng \
      iproute \
      net-tools \
      hostname \
      which \
      vim-minimal \
      less \
      nmap-ncat && \
    dnf clean all

RUN systemctl mask dev-hugepages.mount sys-fs-fuse-connections.mount || true

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY boot.sh /usr/local/bin/boot.sh
COPY freeipa-client-bootstrap.service /etc/systemd/system/freeipa-client-bootstrap.service

RUN chmod 0755 /usr/local/bin/entrypoint.sh /usr/local/bin/boot.sh && \
    systemctl enable sshd sssd oddjobd && \
    systemctl enable freeipa-client-bootstrap.service

CMD ["/usr/local/bin/boot.sh"]
