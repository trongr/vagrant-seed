# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

BOX = "ubuntu/trusty64"
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
    puppet.options = [
        '--verbose',
        # "--debug",
        ]
  end

  config.vm.network :forwarded_port, host: 4567, guest: 80, auto_correct: true
  config.vm.synced_folder ".", "/home/vagrant/nv", create: true, group: GROUP, owner: OWNER
  # store all your dev stuff, e.g. cpp projects in ~/vm, so it's accessible in vm
  config.vm.synced_folder "~/vm", "/home/vagrant/vm", create: true, group: GROUP, owner: OWNER

  config.vm.provider PROVIDER do |vb|
    vb.customize ["modifyvm", :id, "--memory", RAM]
  end

end
