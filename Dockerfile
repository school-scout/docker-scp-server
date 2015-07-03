FROM debian:stable

RUN apt-get update
RUN apt-get install -y openssh-server rssh \
 && rm -f /etc/ssh/ssh_host_*

RUN useradd --uid 1000 --no-create-home --shell /usr/bin/rssh data \
 && mkdir /home/data \
 && chown data: /home/data \
 && chmod 0700 /home/data

ENV AUTHORIZED_KEYS_FILE /authorized_keys
RUN echo "AuthorizedKeysFile $AUTHORIZED_KEYS_FILE" >>/etc/ssh/sshd_config \
 && touch $AUTHORIZED_KEYS_FILE \
 && chown data $AUTHORIZED_KEYS_FILE \
 && chmod 0600 $AUTHORIZED_KEYS_FILE
RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd

RUN echo "allowscp" >> /etc/rssh.conf
RUN echo "allowsftp" >> /etc/rssh.conf

ADD entrypoint.sh /

CMD ["/entrypoint.sh"]
EXPOSE 22
VOLUME /home/data
