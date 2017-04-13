{% set tmpdir = '/tmp/drone' %}

# Add the Dockerfile.
{{ tmpdir }}/Dockerfile:
  file.managed:
    - source: salt://drone/drone/Dockerfile
    - makedirs: True

# Create drone binary.
create-binary:
  salt.state:
    - sls: drone.builder.build
    - tgt: 'rpi-master'

# Build the image.
rpi-cluster/drone:
  dockerng.image_present:
    - build: {{ tmpdir }}
    - onchanges:
      - file: {{ tmpdir }}/Dockerfile
      - file: {{ tmpdir }}/release/drone
