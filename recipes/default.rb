#
# Cookbook Name:: serf
# Recipe:: default
#
# Copyright (C) 2013 Tyler Fitch
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# piece together the host attributes to get the right version of Serf
# the two key variances are 32-bit vs 64-bit and what version of Serf to request
os = node['os']
arch = node['kernel']['machine'] =~ /x86_64/ ? "amd64" : "386"
version = node['serf']['version'] === "latest" ? "latest" : "v/#{node['serf']['version']}"

# construct the download URL from the known info
serf_url = "#{node['serf']['src_url']}#{version}/#{os}/#{arch}"

# download the Linux artifact to the /tmp dir
remote_file "/tmp/serf.zip" do
   source serf_url
   mode 0644
   action :create_if_missing
end

# yes, this does assume 'unzip' is already installed on the system
execute "extract Serf zip to system" do
  command "unzip /tmp/serf.zip -d #{node['serf']['dir']}"
  not_if { ::File.exists?("#{node['serf']['dir']}/serf")}
end