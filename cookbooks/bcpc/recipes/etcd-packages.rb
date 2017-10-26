# Cookbook Name:: bcpc
# Recipe:: etcd-packages
#
# Copyright 2018, Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package 'python-futurist'

cookbook_file '/usr/local/bin/etcd' do
  source   'etcd'
  cookbook 'bcpc-binary-files'
  mode     '00755'
end

cookbook_file '/usr/local/bin/etcdctl' do
  source   'etcdctl'
  cookbook 'bcpc-binary-files'
  mode     '00755'
end

directory '/var/cache/etcd3gw'

cookbook_file '/var/cache/etcd3gw/etcd3gw.tar.gz' do
  source   'etcd3gw.tar.gz'
  cookbook 'bcpc-binary-files'
  notifies :run, 'execute[pip install etcd3gw]', :immediately
end

execute 'pip install etcd3gw' do
  action :nothing
  command 'pip install /var/cache/etcd3gw/etcd3gw.tar.gz'
end
