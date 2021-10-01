# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/hirsute64"
  config.vm.box_check_update = false

  (0..2).each do |i|
    config.vm.define "nomad-#{i}" do |node|
      node.vm.hostname = "nomad-#{i}"
      node.vm.provider "virtualbox" do |v|
        v.memory = 8192
        v.cpus = 4
      end
      last_ip = i + 4
      node.vm.network "private_network", ip: "192.168.50.#{last_ip}"
      node.vm.network "forwarded_port", guest: 4646, host: 14646 + i, guest_ip: "192.168.50.#{last_ip}"
      node.vm.provision "shell", inline: <<-SHELL
        curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
        sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update && sudo apt-get install -y nomad docker-ce docker-ce-cli containerd.io
      SHELL
      node.vm.provision "file", source: "./nomad.hcl", destination: "/tmp/nomad.hcl"
      node.vm.provision "file", source: "./nomad.sh", destination: "/tmp/nomad.sh"
      node.vm.provision "file", source: "./nomad_setup.sh", destination: "/tmp/nomad_setup.sh"
      node.vm.provision "shell", inline: <<-SHELL
        sudo mv /tmp/nomad.hcl /etc/nomad.d/
        sudo mv /tmp/nomad.sh /etc/profile.d/
        sudo chmod 700 /tmp/nomad_setup.sh
        sudo /tmp/nomad_setup.sh
        sudo systemctl enable nomad
        sudo systemctl start nomad
      SHELL
    end
  end
end
