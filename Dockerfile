FROM quay.io/kubernetes-ingress-controller/custom-error-pages-amd64:0.4

LABEL org.opencontainers.image.source https://github.com/caktus/custom-error-pages

COPY www /www

CMD ["/custom-error-pages"]
