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


Updating this repo
------------------

Every push to the ``master`` branch will get run by Github Actions and a new docker
image will be build and pushed to the Github Container Repository with a tag of ``latest``:
`https://github.com/orgs/caktus/packages/container/package/custom-error-pages
<https://github.com/orgs/caktus/packages/container/package/custom-error-pages>`_

If you add a git tag to the master branch with a ``v`` prefix, then Github Actions will
build an image with that tag (without the ``v`` prefix). So tagging the master branch
with ``v1.0`` and pushing it will result in this image being built::

  ghcr.io/caktus/custom-error-pages:1.0


References / Inspirations
-------------------------

* https://github.com/kubernetes/ingress-nginx/tree/master/docs/examples/customization/custom-errors
* https://dev.to/kenmoini/custom-kubernetes-ingress-default-backend-and-error-pages-3alh
