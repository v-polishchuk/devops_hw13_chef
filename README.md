### Run Chef Infra server
All settings are available in `Vagrantfile` 
````
vagrant up
````
If you have problems with virtualbox IP addresses limitation add ` * $chef_server_ip` to `/etc/vbox/networks.conf`

### Set `knife` on workstation 
Run knife configuration.
````
knife configure
````
Set `$chef_org_access_file` as server URL and `$chef_user_name` as user.
Copy `./certs/USERNAME.pem` key file to `~/.chef/USERNAME.pem`

add `$chef_server_ip $chef_server_domain` to `/etc/hosts`
````
echo 192.168.33.199 server.chef-vm | sudo tee -a /etc/hosts
````
Add chef-server certificates
````
knife ssl fetch
knife supermarket install mysql
knife cookbook upload mysql --include-dependencies
knife cookbook upload my-mysql --cookbook-path ./cookbooks
knife bootstrap 192.168.33.100 \
    -P vagrant \
    -U vagrant \
    --node-name mysql \
    --sudo \
    --run-list recipe[my-mysql]
````

### Verify MySQL
````
vagrant ssh chef_node
service mysql status
````