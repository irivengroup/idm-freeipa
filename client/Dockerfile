FROM rockylinux:9

ENV container=docker

RUN dnf -y update && \
    dnf -y install \
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
      vim \
      less \
      nmap-ncat && \
    dnf clean all

RUN systemctl enable sshd sssd oddjobd || true

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 0755 /usr/local/bin/entrypoint.sh

CMD ["/usr/local/bin/entrypoint.sh"]
