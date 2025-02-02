#!/bin/bash
######################################################################
# These scripts are meant to be run in user mode as they modify
# usr settings line .bashrc and .bash_aliases
# Copyright 2022, 2024 John J. Rofrano All Rights Reserved.
######################################################################

echo "**********************************************************************"
echo "Establishing Architecture..."
echo "**********************************************************************"
# Convert inconsistent architectures (x86_64=amd64) (aarch64=arm64)
ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
echo "Architecture is:" $ARCH

echo "**********************************************************************"
echo "Installing K3D Kubernetes..."
echo "**********************************************************************"
curl -s "https://raw.githubusercontent.com/rancher/k3d/main/install.sh" | sudo bash
echo "Creating kc and kns alias for kubectl..."
echo "alias kc='/usr/local/bin/kubectl'" >> $HOME/.bash_aliases
echo "alias kns='kubectl config set-context --current --namespace'" >> $HOME/.bash_aliases
sudo sh -c 'echo "127.0.0.1 cluster-registry" >> /etc/hosts'

echo "**********************************************************************"
echo "Installing K9s..."
echo "**********************************************************************"
curl -L -o k9s.tar.gz "https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_Linux_$ARCH.tar.gz"
tar xvzf k9s.tar.gz
sudo install -c -m 0755 k9s /usr/local/bin
rm k9s.tar.gz

echo "**********************************************************************"
echo "Installing Skaffold..."
echo "**********************************************************************"
curl -Lo skaffold "https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-$ARCH"
sudo install skaffold /usr/local/bin/

echo "**********************************************************************"
echo "Installing DevSpace..."
echo "**********************************************************************"
curl -Lo devspace "https://github.com/loft-sh/devspace/releases/latest/download/devspace-linux-$ARCH"
sudo install -c -m 0755 devspace /usr/local/bin

echo "**********************************************************************"
echo "Installing Stern..."
echo "**********************************************************************"
curl -L -o stern.tar.gz "https://github.com/stern/stern/releases/download/v1.32.0/stern_1.32.0_linux_$ARCH.tar.gz"
tar xvzf stern.tar.gz
sudo install -c -m 0755 stern /usr/local/bin
rm stern.tar.gz LICENSE

echo "**********************************************************************"
echo "Installing Knative CLI..."
echo "**********************************************************************"
curl -L -o kn "https://github.com/knative/client/releases/download/knative-v1.17.0/kn-linux-$ARCH"
sudo install -c -m 0755 kn /usr/local/bin
rm kn

echo "**********************************************************************"
echo "Installing Tekton CLI..."
echo "**********************************************************************"
if [ $ARCH == amd64 ]; then
    curl -L https://github.com/tektoncd/cli/releases/download/v0.39.1/tkn_0.39.1_Linux_x86_64.tar.gz --output tekton.tar.gz
else
    curl -L https://github.com/tektoncd/cli/releases/download/v0.39.1/tkn_0.39.1_Linux_aarch64.tar.gz --output tekton.tar.gz
fi;
tar xvzf tekton.tar.gz tkn
sudo install -c -m 0755 tkn /usr/local/bin
rm tekton.tar.gz tkn


echo "**********************************************************************"
echo "Install OpenShift 4 CLI..."
echo "**********************************************************************"
# OpenShift CLI has platform specific installs
if [ $ARCH == amd64 ]; then
    echo "Installing OpenShift for Intel..."
    curl -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux.tar.gz --output oc.tar.gz
else
    echo "Installing OpenShift for $ARCH ..."
    curl -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux-$ARCH.tar.gz --output oc.tar.gz
fi;
sudo tar xvzf oc.tar.gz -C /usr/local/bin/ oc
sudo ln -s /usr/local/bin/oc /usr/bin/oc
rm oc.tar.gz

echo "**********************************************************************"
echo "Tools Installation Complete!"
echo "**********************************************************************"
