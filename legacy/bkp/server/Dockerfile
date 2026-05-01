FROM freeipa/freeipa-server:rocky-9

COPY entrypoint.sh /usr/local/sbin/idm-entrypoint.sh
RUN chmod +x /usr/local/sbin/idm-entrypoint.sh

ENTRYPOINT ["/usr/local/sbin/idm-entrypoint.sh"]