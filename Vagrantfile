# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The '2' in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
#

# Define the distribution to use (default is Ubuntu)
distribution = ENV['DISTRIBUTION'] || 'ubuntu'

Vagrant.configure("2") do |config|
  # Box settings
  if distribution == 'ubuntu'
    config.vm.box = "ubuntu/focal64"
  else 
    config.vm.box = "xtangle/pop_os-20.04"
    config.vm.box_version = "202012.25.0"
  end

  # VM settings
  config.vm.define "vagrant-dev" do |vm|
    vm.vm.hostname = "vagrant-" + distribution
    # vm.vm.network "private_network", ip: "192.168.18.12"
    # vm.vm.network 'private_network', ip: '192.168.56.10'

    # Provider-specific settings
    vm.vm.provider "virtualbox" do |vb|
      vb.gui = true # open VirtualBox GUI when `vagrant up`
      vb.memory = "8196"
      vb.name =  "vagrant-" + distribution
      vb.cpus = "4"

      vb.customize ['modifyvm', :id, '--vram', '256']
      vb.customize ['modifyvm', :id, '--accelerate2dvideo', 'off']
      vb.customize ['modifyvm', :id, '--accelerate3d', 'on']
      vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
      vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
      vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
    end

    # Env variable provisioning
    vm.vm.provision "ansible" do |ansible|
      ansible.playbook = "env_secrets.yml"
      ansible.ask_vault_pass = true
      ansible.extra_vars = {
        ansible_python_interpreter: "/usr/bin/python3"
      }
    end

    # Export variables
    vm.vm.provision "shell", inline: <<-SHELL
      . /home/vagrant/.zshenv
    SHELL

    # Main Ansible provisioning
    vm.vm.provision "ansible" do |ansible|
      ansible.playbook = "main.yml"
      ansible.extra_vars = {
        ansible_python_interpreter: "/usr/bin/python3",
        ansible_become_pass: "vagrant"
      }
      ansible.tags = "apt"
    end

  end
end

