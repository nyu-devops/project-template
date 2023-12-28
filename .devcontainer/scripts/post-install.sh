#!/bin/bash
#
# These must be installed as a user and therefore need to be run
# after the comtainer has been created.
#
echo Setting up registry.local...
sudo bash -c "echo '127.0.0.1    cluster-registry' >> /etc/hosts"
echo "Setup complete"