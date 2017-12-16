icinga2 Cookbook
==================

[![Cookbook](https://img.shields.io/github/tag/icinga/chef-icinga2.svg)](https://github.com/icinga/chef-icinga2) [![Build Status](https://travis-ci.org/Icinga/chef-icinga2.svg?branch=master)](https://travis-ci.org/Icinga/chef-icinga2) [![Build Status](https://jenkins-01.eastus.cloudapp.azure.com/job/icinga2-cookbook/badge/icon)](https://jenkins-01.eastus.cloudapp.azure.com/job/icinga2-cookbook/)

![Icinga Logo](https://www.icinga.com/wp-content/uploads/2014/06/icinga_logo.png)

This is a [Chef] cookbook to manage [Icinga2] using Chef LWRP.


>> For Production environment, always prefer the [most recent release](https://supermarket.chef.io/cookbooks/icinga2).


## Repository

https://github.com/Icinga/chef-icinga2


## Chef Supermarket

https://supermarket.chef.io/cookbooks/icinga2


## Issue Tracking

For issue reporting or any discussion regarding this cookbook, open an issue.


## Supported Platform

- CentOS
- Amazon
- Debian
- Ubuntu
- Windows 10, Server 2012 R2


## Chef Version

- 12
- 13


## Contributing
See CONTRIBUTING.md


## Major Changes

### v4.0.0

* Split icinga2 cookbook into different cookbooks
  - created cookbook `icinga2repo` for icinga2 yum/apt repository setup
  - created cookbook `icingaweb2` for icingaweb2 setup
  - created cookbook `icinga2client` for icinga2 client setup
* `Icinga2` cookbook now only manage `Icinga2` Server. Other components like packages repository, client, and icingaweb2 has been moved to different github repositories.
* `Icinga2 Classic UI` is no longer under development (since Icinga2 v2.8.0).
* `Icinga Web2` setup is managed by cookbook [icingaweb2].
* `Icinga2 Client` setup is managed by cookbook [icinga2client].
* `Icinga2 Repository` setup is managed by cookbook [icinga2repo]. All Icinga2 cookbooks now uses `icinga2repo` for packages repository setup.
* Created a separate file LWRP.md for LWRP Resources.


### v2.9.1

* Icinga2 ClassicUI is disabled by default, you can enable it by setting default['icinga2']['classic_ui']['enable'] value to `true`
* Icingaweb2 installation is done by package instead of git source, you can change it via attribute default['icinga2']['web2']['install_method'] values `package, source`


### v2.8.0

* LWRP `environment` now generates endpoint/zone for every node to allow remote_execution.
* LWRP `environment` now generates pki tickets in a data bag
* Add example recipes to configure a client/remote_api server which allow
external command execution
* Allow to set command_endpoint as var and not only as string


### v2.7.1

* LWRP `environment` now generates conf file with resource name suffix to allow same environment multiple resources.

>> Existing host_ENVIRONMENT.conf configuration files needs to be purged manually to allow new file name configuration files.

```
New File Format:
With Zone: "host_#{environment}_#{zone}_#{resource_name}.conf"
Without Zone: "host_#{environment}_#{resource_name}.conf"

Old File Format:
With Zone: "host_#{environment}_#{zone}.conf"
Without Zone: "host_#{environment}.conf"
```

### v2.6.9

* Attribute `default['icinga2']['user_defined_objects_d']` is deprecated. For User defined configuration directories,
use `Array` attribute `default['icinga2']['user_defined_objects_dir']` instead.

### v2.0.1

* icinga web2 uri updated to `/icingaweb2`

* epel repository is by default enabled for rhel platform family except amazon platform


### v0.10.1

* Deprecated node *features* attribute and recipe `icinga2::server_features` in favour of LWRP `feature`


### v0.7.0

* LWRP `environment` now generates different conf file with zone name if resource attribute `zone` is defined

**file name:**

```
file name without zone: `host_#{environment}_#{resource_name}.conf`

file name with zone: `host_#{environment}_#{zone}_#{resource_name}.conf`
```

>> Note: Cookbook version prior to v0.7.0 users must delete
  configuration file `host_#{environment}.conf` manually if
  `zone` attribute is defined.

>> Note: Cookbook version prior to v2.7.1 users must delete
  configuration files `host_#{environment}.conf / host_#{environment}_#{zone}.conf` manually.

## Cookbook Dependencies

- ulimit
- yum-epel
- chocolatey
- icinga2repo


## Recipes

- `icinga2::default`     	- run_list recipe

- `icinga2::install`     	- install icinga2 package

- `icinga2::config`     	- configure icinga2

- `icinga2::objects`       - manages icinga2 default objects/templates objects if `node['icinga2']['disable_conf_d']` is set in which case `conf.d` objects config is not included in `icinga2.conf` and objects are created using LWRP

- `icinga2::service`     	- configure icinga2 service


## Icinga2 Default Configuration Directory

If you are using this cookbook to manage `icinga2` configuration, set `default['icinga2']['disable_conf_d']` to `true`.

Cookbook generated configuration files using LWRP are created under directory `default['icinga2']['objects_dir']`.

>> `default['icinga2']['disable_conf_d']` default value is set to `true`.


## Icinga2 Cookbooks and Recipes

### How to Install and Configure Icinga2 Server?

Add recipe `icinga2::default` to run_list.


### How to Setup Icinga2 YUM/APT Repository?

Cookbook `icinga2repo::default` is used to setup icinga2 yum/apt repository.
For more information, see cookbook [icinga2repo].


### How to Install and Configure Icinga2 Client?

Add recipe `icinga2client::default` to run_list.
For more information, see cookbook [icinga2client].


### How to Install and Configure Icingaweb2?

Add recipe `icingaweb2::default` to run_list.
For more information, see cookbook [icingaweb2].


## Icinga2 Cluster Deployment

Icinga2 Distributed / HA cluster setup examples will be added soon.


## Icinga2 Monitor a Chef Environment Nodes

This cookbook does not only provide management of Icinga2 server & objects, it also provides
automation around Chef environment.

Using LWRP `environment` a whole environment nodes can be added to `Host` objects with environment wide `Host` object parameters.

There are certain functionalities added to LWRP `environment`, like:

- define icinga2 `Host` parameters for an entire environment

- auto create `HostGroup` object for an entire chef environment

- auto create `HostGroup` object for node's `application` attribute to group nodes for an entire chef environment `application` type

- auto create `HostGroup` object for node's `cluster` attribute to group nodes for a chef environment `cluster`

- auto add chef node Cloud attributes as `Host` custom `vars`, currently only AWS EC2 attributes are supported, but is easy to extend the support to other cloud providers

- auto create `HostGroup` list for a chef environment node

- limit a chef environment spreaded across multiple regions to icinga2 server region, e.g. in multi region ec2 production environment, one would want to setup an icinga2 server in region `us-east-1` just to monitor `us-east-1` nodes, but not the production nodes of other regions, like `ap-southeast-1`

- allow chef node to determine `host.address` from `node['fqdn']` DNS resolution instead of `node['ipaddress']` and either ignore chef node if failed to resolve DNS or fallback to use `node['ipaddress']` as `host.address`

- exclude a node by `run_list` role, not yet tested

- exclude a node by `run_list` role, not yet tested

- filter chef node if match certain node attributes

- override an environment and use an entire different `search_pattern`, this feature extends LWRP `environment` functionality to select nodes by a user given search pattern

- `Host` object attribute `display_name` is set to chef node hostname

- can exclude chef nodes from icinga2 monitoring if attribute `node['monitoring_off']` is set


Simply create a LWRP resource for a chef environment, to start monitoring all nodes in that environment. More details can be found in examples.


## Icinga2 Monitor an User Defined Chef Environment Nodes/HostGroups

Last section explains the benefits of using LWRP `environment` using in built library search function to determine `chef_environment` nodes / icinga2 Host and auto create icinga2 HostGroup.

This section explains how a user can provide a custom inventory list of nodes, host groups etc.

To find all the valid chef nodes for a chef environment, this cookbook uses default library `icinga2::search`. There are lots of custom & cloud specific attributes embedded in it which may or may not work for every scenarios.

To overcome and make it less enforcing, LWRP `environment` has a Hash attribute `env_resources` which can be used by an user from a wrapper cookbook recipe to pass chef environment nodes & hostgroups & endpoints & zones. If this attribute is set, cookbook will not use default library to search chef_environment nodes and will create Host objects for user defined values.

`env_resources` Hash attributes has below valid key names:

- nodes - Hash of {:Hostfqdn => {icinga2 Host attributes}, :Hostfqdn => {icinga2 Host attributes}, …}
- clusters - Array of cluster HostGroups […] **if any**
- applications - Array of application HostGroups […] **if any**
- roles - Array of roles HostGroups […] **if any**

e.g.
```ruby
icinga2_environment 'UserDefinedEnvironment' do
  import node['icinga2']['object']['host']['import']
  environment 'production'
  check_interval '1m'
  retry_interval '10s'
  max_check_attempts 3
  action_url '/pnp4nagios/graph?host=$HOSTNAME$&srv=_HOST_'
  env_resources :nodes => {:fqdn => {attrs}, :fqdn => {attrs}}
end
```

For more details about nodes attributes, check LWRP `environment` object template.

>> Like `env_resources`, user can also define custom template for LWRP `environment` using attribute `cookbook` and `template`.


## Icinga2 Global Host Custom Vars

**environment LWRP Host Vars**

LWRP `environment` resources sets Host custom vars for each node via node `Hash` attribute -
`node['icinga2']['client']['custom_vars']`. All defined `vars` will be added to `Host` object.


**host LWRP Host Vars**

When using `icinga2_host` LWRP, node custom vars will not be added automatically. There will be no search performed as the `Host` object could be different than a chef `Node`.

To add `Host` custom vars, use Hash attribute `custom_vars`.

A resource attribute will be added to `icinga2_host` LWRP to perform a search to fetch custom vars defined for a node, so that manual addition is not required.


## Icinga2 Node Attributes as Host Custom Vars

`environment` resource attribute `add_node_vars` can add a node attribute to Host custom vars.

e.g. to add a custom var `hardware` with value of node attribute `node['dmi']['system']['manufacturer']`

```
icinga2_environment 'environment' do
  add_node_vars 'hardware' => %w(dmi system manufacturer)
end
```

It will add a custom var `vars.hardware` to environment Host objects.


## Icinga2 User Defined Objects / Configuration


Attribute `node['icinga2']['user_defined_objects_dir']` manages user defined configuration directories location.

Directories will be created under `/etc/icinga2/` and also included in `icinga2.conf`.


## LWRP

See LWRP.md for icinga2 resources.


## Cookbook Advanced Attributes

* `default['icinga2']['ignore_version']` (default: `false`): ignore icinga2 package version

* `default['icinga2']['disable_conf_d']` (default: `true`): disable icinga2 `conf.d` default configuration directory in `icinga2.conf` and use LWRP to manage icinga2 objects / templates

* `default['icinga2']['disable_repository_d']` (default: `false`): disable icinga2 `repository.d` directory in `icinga2.conf`

* `default['icinga2']['include_itl']` (default: `itl, plugins`): `icinga2.conf` include `itl` array attribute

* `default['icinga2']['add_cloud_custom_vars']` (default: `true`): add cloud node attributes, limited cloud provider support is available

* `default['icinga2']['add_inet_custom_vars']` (default: `false`): add node inet ip addresses custom vars

* `default['icinga2']['features_enabled_dir']` (default: `/etc/icinga2/features-enabled`): icinga2 enabled features location

* `default['icinga2']['features_available_dir']` (default: `/etc/icinga2/features-available`): icinga2 available features location

* `default['icinga2']['cluster_attribute']` (default: `nil`): icinga2 node cluster attribute name to add node cluster attribute and value to node vars

* `default['icinga2']['application_attribute']` (default: `nil`): icinga2 node application attribute name to add node application attribute and value to node vars

* `default['icinga2']['enable_cluster_hostgroup']` (default: `true`): creates icinga2 HostGroup Objects for environment clusters

* `default['icinga2']['enable_application_hostgroup']` (default: `true`): creates icinga2 HostGroup Objects for environment application types

* `default['icinga2']['enable_role_hostgroup']` (default: `false`): creates icinga2 HostGroup Objects for environment roles

* `default['icinga2']['limit_region']` (default: `true`): whether to limit monitoring to icinga2 server region, e.g. for ec2 collect nodes belongs to same region

* `default['icinga2']['host_display_name_attr']` (default: `hostname`): whether to use `hostname` or `fqdn` or `name` (chef node name) for environment resource Host Object attribute `display_name`, options: hostname fqdn

* `default['icinga2']['use_fqdn_resolv']` (default: `false`): whether to determine node `address` from fqdn

* `default['icinga2']['failover_fqdn_address']` (default: `true`): whether to use ohai attribute `node['ipaddress']` if node fqdn does not exists

* `default['icinga2']['ignore_node_error']` (default: `false`): whether to ignore node errors if node fqdn, hostname and chef_environment is missing while collecting for a chef environment

* `default['icinga2']['ignore_resolv_error']` (default: `true`): whether to ignore node fqdn resolve errors while collecting for a chef environment

* `default['icinga2']['enable_env_pki']` (default: `false`): whether to create env endpoints, zones and pki_tickets

* `default['icinga2']['enable_env_custom_pki']` (default: `false`): LWRP Parameter, should not be a node attribute



## Cookbook Core Attributes

* `default['icinga2']['version']` (default: `2.8.0-X, calculated`): icinga2 package version

* `default['icinga2']['setup_epel']` (default: `true`): if set includes cookbook recipe `yum-epel::default` for rhel and fedora platform_family

* `default['icinga2']['cookbook']` (default: `icinga2`): icinga2 resources cookbook name

* `default['icinga2']['conf_dir']` (default: `/etc/icinga2`): icinga2 configuration location

* `default['icinga2']['conf_d_dir']` (default: `/etc/icinga2/conf.d`): icinga2 conf.d directory location

* `default['icinga2']['pki_dir']` (default: `/etc/icinga2/pki`): icinga2 pki directory location

* `default['icinga2']['scripts_dir']` (default: `/etc/icinga2/scripts`): icinga2 script directory location

* `default['icinga2']['zones_dir']` (default: `/etc/icinga2/zones.d`): icinga2 zones.d directory location

* `default['icinga2']['databag']` (default: `icinga2`): icinga2 databag name, currently not used

* `default['icinga2']['objects_d']` (default: `objects.d`): cookbook created icinga2 Object/Templates resources directory name

* `default['icinga2']['objects_dir']` (default: `/etc/icinga2/objects.d`): cookbook created icinga2 Object/Templates resources directory location

* `default['icinga2client']['var_dir']` (default: `calculated`): icinga2 run directory

* `default['icinga2']['run_dir']` (default: `/var/run/icinga2`): icinga2 run directory

* `default['icinga2']['run_cmd_dir']` (default: `/var/run/icinga2/cmd`): icinga2 location for process `icinga2.cmd`

* `default['icinga2']['cache_dir']` (default: `/var/cache/icinga2`): icinga2 cache directory location

* `default['icinga2']['spool_dir']` (default: `/var/spool/icinga2`): icinga2 spool directory location

* `default['icinga2']['lib_dir']` (default: `/var/lib/icinga2`): icinga2 lib directory location

* `default['icinga2']['log_dir']` (default: `/var/log/icinga2`): icinga2 core process log directory location

* `default['icinga2']['cache_dir']` (default: `/var/cache/icinga2`): icinga2 cache directory location

* `default['icinga2']['perfdata_dir']` (default: `/var/spool/icinga2/perfdata`): icinga2 perfdata directory location

* `default['icinga2']['service_name']` (default: `icinga2`): icinga2 process name

* `default['icinga2']['service_config_file']` (default: `/etc/default/icinga2`): icinga2 * process configuration file

* `default['icinga2']['plugins_dir']` (default: `/usr/lib/nagios/plugins`): icinga2 plugins directory location

* `default['icinga2']['custom_plugins_dir']` (default: `/opt/icinga2_custom_plugins`): icinga2 custom plugins directory

* `default['icinga2']['admin_user']` (default: `icingaadmin`): icinga2 admin user

* `default['icinga2']['user']` (default: `icinga`): icinga2 user

* `default['icinga2']['group']` (default: `icinga`): icinga2 user group

* `default['icinga2']['cmdgroup']` (default: `icingacmd`): icinga2 cmd user group

* `default['icinga2']['user_defined_objects_dir']` (default: `['user_defined_objects']`): user defined configuration directories, each directory is included in `icinga2.conf` file.

* `default['icinga2']['endpoint_port']` (default: `5665`): icinga2 endpoint port

* `default['icinga2']['version_suffix']` (default: `calculated`): icinga2 package suffix



## Cookbook Icinga2 Constants Attributes

* `default['icinga2']['constants']['NodeName']` (default: `node['fqdn']`): icinga2 NodeName constant

* `default['icinga2']['constants']['PluginDir']` (default: `node['icinga2']['plugins_dir']`): icinga2 plugins directory location

* `default['icinga2']['constants']['ManubulonPluginDir']` (default: `node['icinga2']['plugins_dir']`): icinga2 plugins directory location

* `default['icinga2']['constants']['TicketSalt']` (default: `ed25aed394c4bf7d236b347bb67df466`): icinga2 default TicketSalt key


## Cookbook Icinga2 Host Object default Attributes

* `default['icinga2']['object']['global-templates']` (default: `false`)

* `default['icinga2']['object']['host']['import']` (default: `'generic-host`)

* `default['icinga2']['object']['host']['max_check_attempts']` (default: `3`)

* `default['icinga2']['object']['host']['check_period']` (default: `nil`)

* `default['icinga2']['object']['host']['notification_period']` (default: `nil`)

* `default['icinga2']['object']['host']['check_interval']` (default: `1800`)

* `default['icinga2']['object']['host']['retry_interval']` (default: `60`)

* `default['icinga2']['object']['host']['enable_notifications']` (default: `true`)

* `default['icinga2']['object']['host']['enable_active_checks']` (default: `true`)

* `default['icinga2']['object']['host']['enable_passive_checks']` (default: `false`)

* `default['icinga2']['object']['host']['enable_event_handler']` (default: `true`)

* `default['icinga2']['object']['host']['enable_flapping']` (default: `true`)

* `default['icinga2']['object']['host']['enable_perfdata']` (default: `true`)

* `default['icinga2']['object']['host']['event_command']` (default: `nil`)

* `default['icinga2']['object']['host']['flapping_threshold']` (default: `nil`)

* `default['icinga2']['object']['host']['volatile']` (default: `nil`)

* `default['icinga2']['object']['host']['check_command']` (default: `hostalive`)

* `default['icinga2']['object']['host']['zone']` (default: `nil`)

* `default['icinga2']['object']['host']['command_endpoint']` (default: `nil`)


## Cookbook Ulimit Attributes

 * `default['icinga2']['limits']['memlock']` (default: `unlimited`): Icinga2 service user memory limit

 * `default['icinga2']['limits']['nofile']` (default: `48000`): Icinga2 service user file limit

 * `default['icinga2']['limits']['nproc']` (default: `unlimited`): Icinga2 service user process limit


## Copyright & License

Authors:: Check AUTHORS file

<pre>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</pre>


[Icinga2]: https://www.icinga.com/
[Chef]: https://www.chef.io/
[icinga2repo]: https://github.com/icinga/chef-icinga2repo/
[icinga2client]: https://github.com/icinga/chef-icinga2client/
[icingaweb2]: https://github.com/icinga/chef-icingaweb2/
