#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "httpd" do
  action :install
end



# passengerに必要なパッケージの導入
execute "libcurl-devel" do
  command "yum install -y libcurl-devel"
end
execute "httpd-devel" do
  command "yum install -y httpd-devel"
end
execute "apr-devel" do
  command "yum install -y apr-devel"
end
execute "apr-util-devel" do
  command "yum install -y apr-util-devel"
end


# permissionの変更
execute "chown" do
  command "sudo chown -R vagrant \"/home/vagrant/.rbenv/versions/2.1.0/lib/ruby/gems/2.1.0\""
end

#execute "passenger-install-apache2-module" do
#  command "su vagrant passenger-install-apache2-module"
  #user "vagrant"
#end

# Apache モジュールのビルド・インストール
conf_path = "/etc/httpd/conf.d/passenger.conf"
unless File.exists?(conf_path)
  rbenv_script "passenger_module" do
    user "vagrant"
    code <<-CODE
    passenger-install-apache2-module --auto
    CODE
  end
end
unless File.exists?(conf_path)
  rbenv_script "passenger_module" do
    user "root"
    code <<-CODE
    echo LoadModule passenger_module /home/vagrant/.rbenv/versions/2.1.0/lib/ruby/gems/2.1.0/gems/passenger-4.0.57/buildout/apache2/mod_passenger.so >> #{conf_path}
    echo PassengerRoot /home/vagrant/.rbenv/versions/2.1.0/lib/ruby/gems/2.1.0/gems/passenger-4.0.57 >> #{conf_path}
    echo PassengerDefaultRuby /home/vagrant/.rbenv/versions/2.1.0/bin/ruby >> #{conf_path}
    CODE
  end
end


# permissionの変更
execute "return chown" do
  command "sudo chown -R root '/home/vagrant/.rbenv/versions/2.1.0/lib/ruby/gems/2.1.0'"
end


# 設定ファイルの配置
template "local.conf" do
  path "/etc/httpd/conf.d/local.conf"
  owner "root"
  group "root"
  mode 0644
end
template "passenger.conf" do
  path "/etc/httpd/conf.d/passenger.conf"
  owner "root"
  group "root"
  mode 0644
end



service "httpd" do
  action [ :enable, :start ]
end
