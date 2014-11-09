# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

BOX = "ubuntu/trusty64"
SYNCED_FOLDER = "/home/vagrant/nv"
OWNER = "vagrant"
GROUP = "vagrant"
PROVIDER = "virtualbox"
RAM = "1024"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = BOX

  # config.vm.provision :shell, path: "puppet/bootstrap.sh"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "default.pp"
    puppet.module_path = "puppet/modules"
    puppet.options = ['--verbose']
  end

  config.vm.network :forwarded_port, host: 4567, guest: 80, auto_correct: true
  config.vm.synced_folder ".", SYNCED_FOLDER, create: true, group: GROUP, owner: OWNER

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  config.vm.provider PROVIDER do |vb|
    vb.customize ["modifyvm", :id, "--memory", RAM]
  end

end
