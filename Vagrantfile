
Vagrant.configure("2") do |config|

#  config.ssh.private_key_path='/home/jdowling/.vagrant.d/insecure_private_key'
#  config.ssh.private_key_path='/home/jdowling/.ssh/id_rsa'
   config.ssh.insert_key = false
 
  #  config.vm.define "dn1", autostart: false do |dn1|
  config.vm.define "dn1" do |dn1|
    dn1.vm.box = "opscode-ubuntu-14.04"
    dn1.vm.hostname = 'dn1' 
    dn1.vm.box_url = 'https://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box'

    dn1.vm.network :private_network, ip: "192.168.56.103"
    dn1.vm.network :forwarded_port, guest: 22, host: 10222, id: "ssh"

    dn1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "dn1"]
    end

    dn1.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.json = {
          "karamel" => {
	    "default" =>      { 
              "private_ips" => ["192.168.56.101","192.168.56.102","192.168.56.103"]
	    },
          },
        }
      chef.add_recipe "karamel::install"
    end
  end

  config.vm.define "dn2" do |dn2|
    dn2.vm.box = "opscode-ubuntu-14.04"
    dn2.vm.hostname = 'dn2'
    dn2.vm.box_url = 'https://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box'
    dn2.vm.network :private_network, ip: "192.168.56.102"
    dn2.vm.network :forwarded_port, guest: 22, host: 10322, id: "ssh"

    dn2.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "dn2"]
    end

    dn2.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.json = {
          "karamel" => {
	    "default" =>      { 
              "private_ips" => ["192.168.56.101","192.168.56.102","192.168.56.103"]
	    },
          },
        }
      chef.add_recipe "karamel::install"
    end
  end


  config.vm.define "dn0", primary: true do |dn0|
BOX               = 'opscode-ubuntu-14.04'
BOX_URL           = 'https://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box'

    dn0.vm.box = "opscode-ubuntu-14.04"
    dn0.vm.hostname = 'dn0'
    dn0.vm.box_url = 'https://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box'

    dn0.vm.network :private_network, ip: "192.168.56.101"
    dn0.vm.network :forwarded_port, guest: 22, host: 10122, id: "ssh"
    dn0.vm.network(:forwarded_port, {:guest=>9090, :host=>9090})     
    dn0.vm.network(:forwarded_port, {:guest=>8080, :host=>8080})     


    dn0.vm.provision "file", source: "cluster.yml", destination: "cluster.yml"
    dn0.vm.provision "file", source: "~/.vagrant.d/insecure_private_key", destination: "~/.ssh/id_rsa"    
    dn0.vm.provision "shell", inline: "cp ~/.ssh/authorized_keys ~/.ssh/id_rsa.pub"
    
    dn0.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 14048]
      v.customize ["modifyvm", :id, "--name", "dn0"]      
    end

    dn0.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "cookbooks"
        chef.json = {
          "karamel" => {
	    "default" =>      { 
              "private_ips" => ["192.168.56.101","192.168.56.102","192.168.56.103"]
	    },
          },
        }
        chef.add_recipe "karamel::install"
        chef.add_recipe "karamel::default"     
        chef.add_recipe "karamel::run"     
      end
    
  end

end
