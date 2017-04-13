# This file will configure the Docker service and manage other configuration
# settings on the targets.

{% set master_hostname = salt['pillar.get']('config:master_hostname') %}
{% set secret = salt['pillar.get']('drone:secret') %}
{% set installation_dir = salt['pillar.get']('drone:installation_dir') %}

{{ installation_dir }}/docker-compose.yml:
  file.managed:
    - source: salt://drone/docker-compose.yml
    - makedirs: True
    - template: jinja
    - defaults:
      master_hostname: {{ master_hostname }}
      secret: {{ secret }}

# Install drone.
install-drone:
  salt.state:
    - sls: drone.drone.build
    - tgt: 'rpi-master'

# Install drone plugins.
install-plugins:
  salt.state:
    - sls: drone.plugins
    - tgt: 'rpi-master'
