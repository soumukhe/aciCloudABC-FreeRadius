#FROM freeradius/freeradius-server:latest
FROM soumukhe/smradius1
COPY raddb/ /etc/raddb/
WORKDIR /etc/raddb
