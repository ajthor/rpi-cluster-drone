{% set tmpdir = '/tmp/drone' %}

# Add the Dockerfile.
{{ tmpdir }}/docker/Dockerfile:
  file.managed:
    - source: salt://drone/Dockerfile
    - makedirs: True

# Download the drone arm binary.
{{ tmpdir }}/drone
  file.managed:
    - source: http://downloads.drone.io/release/linux/arm/drone.tar.gz
    - source_hash: http://downloads.drone.io/release/linux/arm/drone.sha256
