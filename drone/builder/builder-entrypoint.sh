#! /bin/sh

# Clone repo.
git clone git://github.com/drone/drone.git $GOPATH/src/github.com/drone/drone
cd $GOPATH/src/github.com/drone/drone

# Build drone binary.
make deps
make gen
make build_static

exec "$@"
