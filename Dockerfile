FROM alpine:3.14

RUN apk add --no-cache bash rssh

RUN echo -e "muchtooeasytoguess\nmuchtooeasytoguess\n" | adduser -u 1000 -h /home/data -s /usr/bin/rssh data

RUN echo -e "PasswordAuthentication no\n" >>/etc/ssh/sshd_config

ENV AUTHORIZED_KEYS_FILE /authorized_keys

RUN echo -e "allowscp\nallowsftp\n" >> /etc/rssh.conf

COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh /

CMD ["/entrypoint.sh"]
EXPOSE 22
VOLUME /home/data
VOLUME /var/local/etc/ssh
