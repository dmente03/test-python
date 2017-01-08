echo "server {
        listen       80;
        server_name  localhost;
        
        access_log  $BASE/logs/access.log;
        error_log   $BASE/logs/error.log;

        location /static/ {
            #Endereço utilizando o vagrant
            #alias /vagrant/test-python/static/;

            #Endereço utilizando a home como base
            alias $BASE/static/;
        }

        location / {
            proxy_pass http://127.0.0.1:8000;
        }
}" > config/nginx.conf