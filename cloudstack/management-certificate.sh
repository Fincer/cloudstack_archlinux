#!/bin/sh

# Temporarily permit non-SSL connections to port 8250
# Fixes cloudstack-management error 'SSL error caught during wrap data: Empty server certificate chain, for local address ...'

# Use only while setting up CloudStack. Provide proper values for production environment.

mysql -u cloud -pcloud -e \
"
USE cloud;
UPDATE configuration SET value='false' WHERE name='ca.plugin.root.auth.strictness';
"

# CloudStack Management server configuration for SSL authentication.
# Recommended to be configured via web UI although direct SQL updates are technically possible.

# ca.framework.provider.plugin 	The configured CA provider plugin
# ca.framework.cert.keysize 	The key size used for certificate generation
# ca.framework.cert.signature.algorithm 	The certificate signature algorithm
# ca.framework.cert.validity.period 	Certificate validity in days
# ca.framework.cert.automatic.renewal 	Whether to auto-renew expiring certificate on hosts
# ca.framework.background.task.delay 	The delay between each CA background task round in seconds
# ca.framework.cert.expiry.alert.period 	The number of days to check and alert expiring certificates
# ca.plugin.root.private.key 	(hidden/encrypted in database) Auto-generated CA private key
# ca.plugin.root.public.key 	(hidden/encrypted in database) CA public key
# ca.plugin.root.ca.certificate 	(hidden/encrypted in database) CA certificate
# ca.plugin.root.issuer.dn 	The CA issue distinguished name used by the root CA provider
# ca.plugin.root.auth.strictness 	Setting to enforce two-way SSL authentication and trust validation
# ca.plugin.root.allow.expired.cert 	Setting to allow clients with expired certificates

# Ref: http://docs.cloudstack.apache.org/en/4.11.2.0/adminguide/hosts.html
