#
# Cookbook:: my-mysql
# Recipe:: default

apt_update 'all platforms' do
  frequency 86400
  action :periodic
end

mysql_service 'default' do
  port '3306'
  version '8.0'
  initial_root_password 'some-password'
  action [:create, :start]
end