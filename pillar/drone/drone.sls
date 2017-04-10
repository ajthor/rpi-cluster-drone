drone:
  # This is the install ation directory for the `docker-compose.yml` file and for certain other required files (if needed).
  installation_dir: /opt/drone
  # In production, this value should be changed to your secret, shared across
  # all drone nodes.
  secret: somesecret
  # Specify plugins to be downloaded by docker. Useful plugins ported to arm
  # are available on Docker Hub by `armhfplugins`.
  plugins:
    - docker:
      - tag: armhfplugins/drone-docker
    - git:
      - tag: armhfplugins/drone-git
