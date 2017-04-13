# This function builds the drone binary so that it runs natively on our system.
# We pull the git repo, build the binary, and copy it out of the created
# container so that we can use it later in our docker build step.

{% set golang_image = salt['pillar.get']('docker:images:golang:tag', 'rpi-cluster/golang') %}
{% set tmpdir = '/tmp/drone-builder' %}

{{ tmpdir }}/Dockerfile:
  file.managed:
    - source: salt://drone/builder/Dockerfile
    - makedirs: True
    - template: jinja
    - defaults:
      golang_image: {{ golang_image }}

{{ tmpdir }}/builder-entrypoint.sh:
  file.managed:
    - source: salt://drone/builder/builder-entrypoint.sh
    - makedirs: True

drone-builder:
  dockerng.image_present:
    - build: {{ tmpdir }}
    - require:
      - file: {{ tmpdir }}/Dockerfile
      - file: {{ tmpdir }}/builder-entrypoint.sh

create-builder-container:
  cmd.run:
    - name: docker create --name builder drone-builder
    - require:
      - dockerng: drone-builder

copy-binary:
  cmd.run:
    - name: docker cp builder:/go/src/github.com/drone/drone/release/drone /tmp/drone/release/drone

# Remove the builder container.
builder:
  dockerng.absent:
    - force: True
    - require:
      - cmd: copy-binary

# Remove the builder image.
remove-buidler:
  dockerng.image_absent:
    - images:
      - drone-builder
    - require:
      - cmd: copy-binary
      - dockerng: builder
