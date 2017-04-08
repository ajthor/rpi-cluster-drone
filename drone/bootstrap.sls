# This file is meant to be run using Salt orchestrate, using a command such as:
# `sudo salt-run state.orchestrate drone.bootstrap`

configure-pillar:
  salt.state:
    - sls: drone.pillar
    - tgt: 'rpi-master'
