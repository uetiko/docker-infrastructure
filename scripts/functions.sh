function readData(){
  SHARED=$(pwd)/shared
  INFRA=$(pwd)/infrastructure/nginx/server/block/

  echo -e "\e[92m 
  Please, provide an account name for the new server config:
  \e[39m"
  read ACCOUNT

  echo -e "\e[92m
  Provide a new domain for the account.
  \e[39m"

  read SUBDOMAIN
}

function create_dir() {
  SSL_PATH=${SHARED}/server/ssl/${ACCOUNT}
  CONF_PATH=${SHARED}/server/conf/${ACCOUNT}

  mkdir -p ${SSL_PATH}
  mkdir -p ${CONF_PATH}
}

function create_cert(){
  openssl genrsa -des3 -out ${SSL_PATH}/${SUBDOMAIN}.key 4096

  openssl rsa \
    -in ${SSL_PATH}/${SUBDOMAIN}.key \
    -out ${SSL_PATH}/${SUBDOMAIN}.pem

  openssl req -new \
    -key ${SSL_PATH}/${SUBDOMAIN}.key \
    -out ${SSL_PATH}/${SUBDOMAIN}.csr

  openssl x509 -req -days 365 \
    -in ${SSL_PATH}/${SUBDOMAIN}.csr \
    -signkey ${SSL_PATH}/${SUBDOMAIN}.key \
    -out ${SSL_PATH}/${SUBDOMAIN}.crt
}

function move_nginx_block() {
  cp infrastructure/nginx/server/block/site.conf ${CONF_PATH}/${SUBDOMAIN}.conf
}

function move_nginx_block_to_infra() {
  cp ${CONF_PATH}/${SUBDOMAIN}.conf etc/infrastructure/nginx/conf.d/
}


function edit_nginx_block(){
  sed -i -e "s/account/${ACCOUNT}/g" \
    ${CONF_PATH}/${SUBDOMAIN}.conf

  sed -i -e "s/subdomain/${SUBDOMAIN}/g" \
    ${CONF_PATH}/${SUBDOMAIN}.conf

  sed -i -e "s/domain/${HOST_NAME}/g" \
    ${CONF_PATH}/${SUBDOMAIN}.conf
}

function select_service(){
  while :
  do
    echo -e "\e[92m
      Provide the service name:
      php
      python
      node
      static
      \e[39m"
    read option
    case $option in
      php)
        cp infrastructure/nginx/server/block/php.conf ${CONF_PATH}/${SUBDOMAIN}.conf
        break
        ;;
      node)
        cp infrastructure/nginx/server/block/node.conf ${CONF_PATH}/${SUBDOMAIN}.conf
        break
        ;;
      static)
        cp infrastructure/nginx/server/block/static.conf ${CONF_PATH}/${SUBDOMAIN}.conf
        break
        ;;
      python)
        cp infrastructure/nginx/server/block/python.conf ${CONF_PATH}/${SUBDOMAIN}.conf
        break
        ;;
    esac
  done
}

function write_host(){
  su -c "echo \"127.0.0.1       ${SUBDOMAIN}.${HOST_NAME}\" >> /etc/hosts"
}