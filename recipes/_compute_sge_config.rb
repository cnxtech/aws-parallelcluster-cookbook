#
# Cookbook Name:: aws-parallelcluster
# Recipe:: _compute_sge_config
#
# Copyright 2013-2015 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the
# License. A copy of the License is located at
#
# http://aws.amazon.com/apache2.0/
#
# or in the "LICENSE.txt" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES
# OR CONDITIONS OF ANY KIND, express or implied. See the License for the specific language governing permissions and
# limitations under the License.

# Mount /opt/sge over NFS
nfs_master = node['cfncluster']['cfn_master']
mount '/opt/sge' do
  device "#{nfs_master}:/opt/sge"
  fstype "nfs"
  options 'hard,intr,noatime,vers=3,_netdev'
  action %i[mount enable]
end

# Setup SGE
link '/etc/profile.d/sge.sh' do
  to '/opt/sge/default/common/settings.sh'
end

link '/etc/profile.d/sge.csh' do
  to '/opt/sge/default/common/settings.csh'
end

directory '/opt/parallelcluster/templates'
directory '/opt/parallelcluster/templates/sge'
link '/opt/parallelcluster/templates/sge/sge_inst.conf' do
  to '/opt/sge/sge_inst.conf'
end
