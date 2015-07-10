#
# Cookbook Name:: total_dbag
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'apt'

httpd_service 'default' do
  action [:create, :start]
end

httpd_config 'dbag' do
  source 'dbag.erb'
  notifies :restart, 'httpd_service[default]'
end

template '/var/www/index.html' do
  source 'index.html.erb'
  variables(
     message: node['simple-web']['message']
  )
end