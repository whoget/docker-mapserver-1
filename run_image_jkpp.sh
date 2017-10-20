docker run -d --restart=always  --name lat_mapserver2 --link postgis:postgis  -p 5222:80 -v /opt/mapserver/map:/map -v /opt/mapserver/var/www:/var/www  lat/mapserver
