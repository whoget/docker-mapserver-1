docker run -d --restart=always --name lat_mapserver_3  -p 5222:80  -v /opt/mapserver/map:/map -v /opt/mapserver/var/www:/var/www  lat_mapserver
