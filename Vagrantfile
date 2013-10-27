# -*- mode: ruby -*-
# vi: set ft=ruby :

# The vagrant-butcher plugin manages your VM client on the Chef server
# to install just `vagrant plugin install vagrant-butcher`
Vagrant.require_plugin "vagrant-butcher"
# removing vagrant-omnibus because the base OS image doesn't have curl or wget
# Vagrant.require_plugin "vagrant-omnibus"
# to install just `vagrant plugin install vagrant-berkshelf`
Vagrant.require_plugin "vagrant-berkshelf"

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "384"]
  end

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # commands to run, even before Chef does. In other words, install curl and a Chef client
  # basically what the Omnibus plugin would do, but it requires curl and curl wasn't there
  config.vm.provision :shell, :path => "bootstrap.sh"

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.vm.define :serf1 do |serf1|
    # To keep the Chef server clients from stepping on each other's toes - unique names for everyone
    serf1.vm.hostname = "chef-serf1-#{ENV['USER']}";

    # Create a private network for the Serf machines to see each other
    serf1.vm.network :private_network, ip: "192.168.50.10"

    # The path to the Berksfile to use with Vagrant Berkshelf
    # serf1.berkshelf.berksfile_path = "./Berksfile"

    # Enabling the Berkshelf plugin. To enable this globally, add this configuration
    # option to your ~/.vagrant.d/Vagrantfile file
    serf1.berkshelf.enabled = true

    # An array of symbols representing groups of cookbook described in the Vagrantfile
    # to exclusively install and copy to Vagrant's shelf.
    # serf1.berkshelf.only = []

    # An array of symbols representing groups of cookbook described in the Vagrantfile
    # to skip installing and copying to Vagrant's shelf.
    # serf1.berkshelf.except = []

    # Enable provisioning with chef server, specifying the chef server URL,
    # and the path to the validation key (relative to this Vagrantfile).
    serf1.butcher.knife_config_file = './.chef/knife.rb'
    serf1.vm.provision :chef_client do |chef|
      chef.chef_server_url        = "https://api.opscode.com/organizations/tfitch"
      chef.validation_client_name = "tfitch-validator"
      chef.validation_key_path    = ".chef/tfitch-validator.pem"

      chef.run_list = [
          "recipe[serf::default]"
      ]
    end
  end

  config.vm.define :serf2 do |serf2|
    # To keep the Chef server clients from stepping on each other's toes - unique names for everyone
    serf2.vm.hostname = "chef-serf2-#{ENV['USER']}";

    # Create a private network for the Serf machines to see each other
    serf2.vm.network :private_network, ip: "192.168.50.20"

    # The path to the Berksfile to use with Vagrant Berkshelf
    # serf2.berkshelf.berksfile_path = "./Berksfile"

    # Enabling the Berkshelf plugin. To enable this globally, add this configuration
    # option to your ~/.vagrant.d/Vagrantfile file
    serf2.berkshelf.enabled = true

    # An array of symbols representing groups of cookbook described in the Vagrantfile
    # to exclusively install and copy to Vagrant's shelf.
    # serf2.berkshelf.only = []

    # An array of symbols representing groups of cookbook described in the Vagrantfile
    # to skip installing and copying to Vagrant's shelf.
    # serf2.berkshelf.except = []

    # Enable provisioning with chef server, specifying the chef server URL,
    # and the path to the validation key (relative to this Vagrantfile).
    serf2.butcher.knife_config_file = './.chef/knife.rb'
    serf2.vm.provision :chef_client do |chef|
      chef.chef_server_url        = "https://api.opscode.com/organizations/tfitch"
      chef.validation_client_name = "tfitch-validator"
      chef.validation_key_path    = ".chef/tfitch-validator.pem"

      chef.run_list = [
          "recipe[serf::default]"
      ]
    end
  end
end
