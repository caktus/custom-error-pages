Custom Error Pages in Kubernetes
================================

The Dockerfile in this repo builds an image that can be used in a kubernetes deployment
to supply custom error pages for nginx.

How to Use
----------

I'm planning to add support to Caktus's django-k8s and k8s-web-cluster Ansible roles
which will allow you to turn on a single flag, which if enabled, will create a service
and deployment named nginx-errors in your cluster. That service will be used as the
``default-backend`` for the ingress-nginx controller, so it will use that service (which
will use the image in this repo) for the HTML pages of the error codes that you specify.

Initial setup
-------------

1. Create a Container Registry `Personal Access Token (CR_PAT)
   <https://github.com/settings/tokens>`_, giving it the ``write:packages`` permission
   (which also gives it ``repo`` permissions).

#. Add that token to your environment (e.g. in ``.envrc``)::

     export CR_PAT_KEY=supersecrettoken

#. Login to the registry::

     echo $CR_PAT | docker login ghcr.io -u <USERNAME> --password-stdin

#. Push the image::

     docker push ghcr.io/caktus/custom-error-pages:latest


TODO
----

* Figure out how to build this image in CI and push to a public image repository
* Figure out how to allow customization of the HTML pages


References / Inspirations
-------------------------

* https://github.com/kubernetes/ingress-nginx/tree/master/docs/examples/customization/custom-errors
* https://dev.to/kenmoini/custom-kubernetes-ingress-default-backend-and-error-pages-3alh
