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
