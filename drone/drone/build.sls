{% set tmpdir = '/tmp/drone' %}

# Add the Dockerfile.
{{ tmpdir }}/Dockerfile:
  file.managed:
    - source: salt://drone/drone/Dockerfile
    - makedirs: True

# Download the drone arm binary.
{{ tmpdir }}/release/drone:
  file.managed:
    - source: http://downloads.drone.io/release/linux/arm/drone.tar.gz
    - source_hash: http://downloads.drone.io/release/linux/arm/drone.sha256
    - makedirs: True

# Build the image.
rpi-cluster/drone:
  dockerng.image_present:
    - build: {{ tmpdir }}
    - onchanges:
      - file: {{ tmpdir }}/Dockerfile
      - file: {{ tmpdir }}/release/drone
