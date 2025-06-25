#!/bin/sh

# Generate conditional forwarding config if variables exist
if [ -n "$CONDITIONAL_DOMAIN" ] && [ -n "$CONDITIONAL_FORWARDERS" ]; then
  echo "zone \"$CONDITIONAL_DOMAIN\" {" > /etc/bind/zones/conditional.conf
  echo "    type forward;" >> /etc/bind/zones/conditional.conf
  echo "    forwarders {" >> /etc/bind/zones/conditional.conf
  
  # Split forwarders by semicolon and add each one
  IFS=';' read -ra ADDR <<< "$CONDITIONAL_FORWARDERS"
  for ip in "${ADDR[@]}"; do
    echo "        ${ip};" >> /etc/bind/zones/conditional.conf
  done
  
  echo "    };" >> /etc/bind/zones/conditional.conf
  echo "};" >> /etc/bind/zones/conditional.conf
  
  # Include the generated config in named.conf
  echo 'include "/etc/bind/zones/conditional.conf";' >> /etc/bind/named.conf
fi

# Start BIND with debug output
echo "Starting BIND with configuration:"
cat /etc/bind/named.conf
exec /usr/sbin/named -f -g