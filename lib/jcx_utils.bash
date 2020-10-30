#!/bin/bash

install_jcx_utils () {
  # VV
  curl https://raw.githubusercontent.com/joshuacox/vv/master/bootstrapvv.sh |sudo bash
  # Roustabout
  curl https://raw.githubusercontent.com/joshuacox/roustabout/master/bootstraproustabout.sh |sudo bash
  # bomsaway
  curl https://raw.githubusercontent.com/joshuacox/bomsaway/master/bootstrapbomsaway.sh |sudo bash
  # SSShutdown
  curl -sL https://git.io/ssshutdown | bash
  # Swappy
  curl https://raw.githubusercontent.com/joshuacox/swappy/master/bootstrap | bash
  # Passgen
  curl https://raw.githubusercontent.com/joshuacox/passgen/master/bootstrappassgen.sh | sh
}
