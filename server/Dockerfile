FROM rockylinux:9

ENV container=docker

RUN dnf -y update && \
    dnf -y install \
      ipa-server \
      ipa-server-dns \
      bind-dyndb-ldap \
      openssh-server \
      openssh-clients \
      sudo \
      chrony \
      procps-ng \
      iproute \
      net-tools \
      hostname \
      which \
      vim \
      less \
      nmap-ncat && \
    dnf clean all

RUN systemctl enable sshd || true

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 0755 /usr/local/bin/entrypoint.sh

VOLUME ["/data"]

CMD ["/usr/local/bin/entrypoint.sh"]
