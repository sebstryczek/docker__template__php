#!/bin/sh

echo "Running: setup.sh"
echo "Current directory:" $(pwd)

DOMAINS=${DOMAINS:=""}

if [ "$DOMAINS" = "" ]
then
    echo "No DOMAINS environment variable value."
    echo "Using self-hosted SSL certifacte..."

    if  [ ! -f /etc/ssl/private/key.pem ]
    then
        echo "Generating new self-hosted SSL certifacte.."
        
        mkcert -install
        mkcert -key-file /etc/ssl/private/key.pem -cert-file /etc/ssl/certs/cert.pem localhost
        
        # Preventing:
        # Restarting Apache httpd web server: apache2AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.20.0.2. Set the 'ServerName' directive globally to suppress this message
        echo "ServerName localhost" >> /etc/apache2/apache2.conf
    fi
else
    echo "DOMAINS: $DOMAINS"

    # Setup SSL here
fi

a2enmod headers
a2enmod ssl

# Add SSL setup for Apache
a2ensite 000-default-ssl.conf

exec apache2-foreground
