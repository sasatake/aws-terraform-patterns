#cloud-config

timezone: Asia/Tokyo
locale: ja_JP.utf8

package_update: true
package_upgrade: true

packages:
  - device-mapper-persistent-data
  - lvm2
  - tc

runcmd:
  - mkdir -p /etc/systemd/system/docker.service.d
  - amazon-linux-extras install -y docker
  - yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
  - systemctl daemon-reload
  - systemctl enable docker
  - systemctl enable kubelet

write_files:
  - content: |
      {
        "exec-opts": ["native.cgroupdriver=systemd"],
        "log-driver": "json-file",
        "log-opts": {
          "max-size": "100m"
        },
        "storage-driver": "overlay2",
        "storage-opts": [
          "overlay2.override_kernel_check=true"
        ]
      }
    path: /etc/docker/daemon.json
    append: false
  - content: |
      [kubernetes]
      name=Kubernetes
      baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
      enabled=1
      gpgcheck=1
      repo_gpgcheck=1
      gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
    path: /etc/yum.repos.d/kubernetes.repo
    append: false
  %{ if node_type == "master" }
  - content: |
      export KUBECONFIG=/etc/kubernetes/admin.conf
    path: /etc/profile.d/k8s.sh
    append: false
  - content: |
      #!/bin/bash
      kubeadm init
      kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
      kubectl taint nodes --all node-role.kubernetes.io/master-
    path: /root/kubeadm_init.sh
    append: false
    permissions: '0755'
  %{ endif }

power_state:
  mode: reboot
