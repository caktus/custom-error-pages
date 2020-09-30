Custom Error Pages in Kubernetes
================================

The Dockerfile in this repo builds an image that can be used in a kubernetes deployment
to supply custom error pages for nginx, as described in the `Kubernetes Ingress
<https://github.com/kubernetes/ingress-nginx/tree/master/docs/examples/customization/custom-errors>`_
documentation.

How to Use
----------

I'm planning to add support to Caktus's k8s-web-cluster Ansible role which will
automatically reference this image, creating a service and deployment named nginx-errors
in your cluster. That service will be used as the ``default-backend`` for the
ingress-nginx controller, so it will use the image in this repo to return HTML pages for
the error codes that you specify.


How to customize
----------------

If you want to customize the error pages that you show, you'll need to fork this repo,
update the contents of the ``www`` directory, and then push your built images to a place
that your Kubernetes cluster can access them.


Initial setup
-------------

1. Create a Container Registry `Personal Access Token (CR_PAT)
   <https://github.com/settings/tokens>`_, giving it the ``write:packages`` and
   ``read:packages`` permissions. (Clicking ``write:packages`` will automatically select
   the ``repo`` permissions, so you should manually unselect ``repo`` to minimize the
   permissions that you give this key.

#. Add that token to your environment (e.g. in ``.envrc``)::

     export CR_PAT_KEY=supersecrettoken

#. Login to the registry::

     echo $CR_PAT | docker login ghcr.io -u <USERNAME> --password-stdin

#. Push the image::

     docker push ghcr.io/caktus/custom-error-pages:latest


eferences / Inspirations
-------------------------

* https://github.com/kubernetes/ingress-nginx/tree/master/docs/examples/customization/custom-errors
* https://dev.to/kenmoini/custom-kubernetes-ingress-default-backend-and-error-pages-3alh
