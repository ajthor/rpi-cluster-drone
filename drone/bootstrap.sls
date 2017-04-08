# This file is meant to be run using Salt orchestrate, using a command such as:
# `sudo salt-run state.orchestrate drone.bootstrap`

# Configure pillar.
configure-pillar:
  salt.state:
    - sls: drone.pillar
    - tgt: 'rpi-master'

# Install drone.
install-drone:
  salt.state:
    - sls: drone.install
    - tgt: '*'

# Configure drone.
configure-drone:
  salt.state:
    - sls: salt.configure
    - tgt: '*'
