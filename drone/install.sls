# This file will configure the Docker service and manage other configuration
# settings on the targets.

{% set master_hostname = salt['pillar.get']('config:master_hostname') %}
{% set secret = salt['pillar.get']('drone:secret') %}

~/drone/docker-compose.yml:
  file.managed:
    - source: salt://drone/drone/docker-compose.yml
    - makedirs: True
    - template: jinja
    - defaults:
      secret: {{ secret }}
