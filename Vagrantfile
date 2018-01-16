Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/xenial64"
    config.vm.provision :shell, path: "bash/environment/install.sh"
    config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = "2"
    end
    config.vm.synced_folder "/home/pavel/projects/vagrant", "/var/www/html", create: true, :mount_options => ["dmode=777", "fmode=666"]
    config.vm.network "private_network", ip: "192.168.33.10"
end
