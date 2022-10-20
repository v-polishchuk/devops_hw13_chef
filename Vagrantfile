$chef_server_ip = '192.168.33.199'
$chef_node_ip   = '192.168.33.100'
$chef_server_domain = 'server.chef-vm'
$chef_node_domain = 'node.chef-vm'

$chef_certs_folder = '/home/vagrant/certs/'

$chef_org_name = 'hw13'
$chef_org_fullname = 'Home Task #13. Chef Provisioning'

$chef_user_name = 'admin'
$chef_user_mail = 'mail@exapmle.com'
$chef_user_pass = 'PASSWD1'


Vagrant.configure(2) do |config|
    config.vm.define :chef_server do |chef_server_config|
        chef_server_config.vm.provider "virtualbox" do |v|
          v.memory = 4096
          v.cpus = 4
        end

        chef_server_config.vm.box = "bento/ubuntu-20.04"
        chef_server_config.vm.synced_folder "./certs", $chef_certs_folder, create: true
        chef_server_config.vm.hostname = $chef_server_domain
        chef_server_config.vm.network 'private_network', ip: $chef_server_ip
        chef_server_config.vm.provision "shell", inline: "apt-get update && apt-get install -y unzip"
        chef_server_config.vm.provision "shell", inline: "sysctl -w vm.max_map_count=262144"
        chef_server_config.vm.provision "shell", inline: "sysctl -w vm.dirty_expire_centisecs=20000"
        chef_server_config.vm.provision "shell", inline: "echo #{$chef_server_ip} #{$chef_server_domain} | sudo tee -a /etc/hosts"
        chef_server_config.vm.provision "shell", inline: "wget -q -P /tmp https://packages.chef.io/files/stable/chef-server/15.1.7/ubuntu/20.04/chef-server-core_15.1.7-1_amd64.deb"
        chef_server_config.vm.provision "shell", inline: "sudo dpkg -i /tmp/chef-server-core_15.1.7-1_amd64.deb"
        chef_server_config.vm.provision "shell", inline: "sudo chef-server-ctl reconfigure --chef-license accept"
        chef_server_config.vm.provision "shell", inline: "sudo chef-server-ctl user-create #{$chef_user_name} FirstName LastName #{$chef_user_mail} #{$chef_user_pass} -f #{$chef_certs_folder}/#{$chef_user_name}.pem"
        chef_server_config.vm.provision "shell", inline: "sudo chef-server-ctl org-list"
        chef_server_config.vm.provision "shell", inline: "sudo chef-server-ctl org-create #{$chef_org_name} '#{$chef_org_fullname}' --association_user #{$chef_user_name} --filename #{$chef_certs_folder}/#{$chef_org_name}.pem"
        chef_server_config.vm.provision "shell", inline: "apt-get clean"
    end

    config.vm.define :chef_node do |chef_node_config|
        chef_node_config.vm.provider "virtualbox" do |v|
          v.memory = 2048
          v.cpus = 2
        end

        chef_node_config.vm.box = "bento/ubuntu-20.04"
        chef_node_config.vm.synced_folder "./certs", "/home/vagrant/certs/", create: true
        chef_node_config.vm.hostname = $chef_node_domain
        chef_node_config.vm.network 'private_network', ip: $chef_node_ip
        chef_node_config.vm.provision "shell", inline: "echo #{$chef_server_ip} #{$chef_server_domain} | sudo tee -a /etc/hosts"
    end
end
