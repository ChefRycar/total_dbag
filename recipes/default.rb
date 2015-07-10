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

chef_gem 'chef-vault' do
  compile_time true if respond_to?(:compile_time)
end

require 'chef-vault'

template '/var/www/index.html' do
  source 'index.html.erb'
  variables(
     user: ChefVault::Item.load('password_vault', 'database')['username'],
     pass: ChefVault::Item.load('password_vault', 'database')['password']
  )
end