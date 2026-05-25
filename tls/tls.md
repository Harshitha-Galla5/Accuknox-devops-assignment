## TLS Configuration

TLS was implemented using Kubernetes Ingress with self-signed SSL certificates.

### Generate TLS Certificates

openssl req -x509 -nodes -days 365 \
-newkey rsa:2048 \
-keyout tls/tls.key \
-out tls/tls.crt \
-subj "/CN=wisecow.local/O=wisecow"

### Create Kubernetes TLS Secret

kubectl create secret tls wisecow-tls \
--key=tls/tls.key \
--cert=tls/tls.crt
