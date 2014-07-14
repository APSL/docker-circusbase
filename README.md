===================================
Docker circus / envtpl base project
===================================

Docker base image for processes managed with circus. Config parameters with envtpl.

Description
===========

Docker image intended for use as a base image for apps which need process management. 

* circus to control processes. http://circus.readthedocs.org/
* envtpl to setup config files on start time, based on environ vars. https://github.com/andreasjansson/envtpl

As an example of envtpl, circus.ini itself is managed with envtpl

Env vars:

Run circus httpd (default False)::

    -e CIRCUS_HTTPD=true    

Run circus statsd (default False)::

    -e CIRCUS_STATSD=true    

