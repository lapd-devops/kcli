echo net.bridge.bridge-nf-call-iptables=1 >> /etc/sysctl.d/99-sysctl.conf
sysctl -p
setenforce 0
sed -i "s/SELINUX=enforcing/SELINUX=permissive/" /etc/selinux/config
sed -i "s/--selinux-enabled //" /etc/sysconfig/docker
yum install -y docker kubelet kubeadm kubectl kubernetes-cni
systemctl enable docker && systemctl start docker
systemctl enable kubelet && systemctl start kubelet
