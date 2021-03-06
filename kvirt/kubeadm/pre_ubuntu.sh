apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
{% if version != None %}
VERSION=$(apt-cache show kubectl | grep Version | grep {{ version }} | head -1 | awk -F: '{print $2}' | xargs)
{% else %}
VERSION=$(apt-cache show kubectl | grep Version | head -1 | awk -F: '{print $2}' | xargs)
{% endif %}
apt-get install -y docker.io kubelet=$VERSION kubectl=$VERSION kubeadm=$VERSION
systemctl enable docker && systemctl start docker
systemctl enable kubelet && systemctl start kubelet
