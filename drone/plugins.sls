# This file downloads all of the drone armhf plugins specified in the pillar.

{% for plugin in salt['pillar.get']('drone:plugins') %}

drone-plugin-{{ plugin }}:
  dockerng.image_present:
    - name: {{ plugin['tag'] }}

{%- endfor %}
