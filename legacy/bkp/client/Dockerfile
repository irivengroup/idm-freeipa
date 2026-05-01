FROM rockylinux:9

RUN dnf -y install \
      freeipa-client \
      ipa-client \
      sssd \
      sssd-tools \
      oddjob \
      oddjob-mkhomedir \
      openssh-server \
      openssh-clients \
      bind-utils \
      iproute \
      iputils \
      sudo \
      authselect \
      procps-ng \
      vim-minimal \
    && dnf clean all \
    && ssh-keygen -A \
    && mkdir -p /run/sshd

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
