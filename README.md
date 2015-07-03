# docker-scp-server

Restricted SSH server which allows SCP / SFTP access only.

## Running

Put your authorized keys in an ENV variable and run the image:

    AUTHORIZED_KEYS=$(cat -e my-authorized-keys)

    docker run -d -e AUTHORIZED_KEYS=$AUTHORIZED_KEYS -p <PORT>:22 -v <DATADIR>:/home/data schoolscout/scp-server

Now you copy into the container (e.g. via scp) as the `data` user:

    scp -P <PORT> <FILE> data@<DOCKER-HOST>:
