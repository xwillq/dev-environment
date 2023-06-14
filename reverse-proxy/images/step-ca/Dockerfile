FROM smallstep/step-ca:0.24.1

# Меняем пользователя на root, чтобы можно было поставить dnsmasq
USER root

RUN apk add dnsmasq

COPY config/dnsmasq.conf /etc/dnsmasq.conf

RUN sed -i '2adnsmasq' /entrypoint.sh

# Возвращаем стандартного пользователя
USER step
