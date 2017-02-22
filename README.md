icinga2 Cookbook
==================

[![Cookbook](https://img.shields.io/github/tag/icinga/chef-icinga2.svg)](https://github.com/icinga/chef-icinga2) [![Build Status](https://travis-ci.org/Icinga/chef-icinga2.svg?branch=master)](https://travis-ci.org/Icinga/chef-icinga2)[![Build Status](https://jenkins-01.eastus.cloudapp.azure.com/job/icinga2-cookbook/badge/icon)](https://jenkins-01.eastus.cloudapp.azure.com/job/icinga2-cookbook/)

![Icinga Logo](https://www.icinga.com/wp-content/uploads/2014/06/icinga_logo.png)

This is a [Chef] cookbook to manage [Icinga2] using Chef LWRP.


More features and attributes will be added over time, **feel free to contribute**
what you find missing!


>> For Production environment, always prefer the [most recent release](https://supermarket.chef.io/cookbooks/icinga2).

## Repository

https://github.com/Icinga/chef-icinga2


## Chef Super Market

https://supermarket.chef.io/cookbooks/icinga2


## Issue Tracking

For issue reporting or any discussion regarding this cookbook, open an issue at [Dev Icinga]. New users need to [Register] first.


## Supported Icinga Version

This cookbook is being developed for Icinga2 - v2.2.x and later versions.


## Supported OS

 This cookbook has been tested on CentOS 6.8, CentOS 7.2 and Ubuntu 14.04.


## Supported Icinga2 Install Types

Currently Icinga2 installation is supported **ONLY** via Repository Packages, as it is a recommended best practice.


## Chef Requirement

This cookbook requires Chef Version 11.x or above.


## Contributing
See CONTRIBUTING.md

## TODO

* add icinga2 web2 configuration support


## Major Changes

###v2.9.1

* Icinga2 ClassicUI is disabled by default, you can enable it by setting default['icinga2']['classic_ui']['enable'] value to `true`
* Icingaweb2 installation is done by package instead of git source, you can change it via attribute default['icinga2']['web2']['install_method'] values `package, source`


###v2.8.0

* LWRP `environment` now generates endpoint/zone for every node to allow remote_execution.
* LWRP `environment` now generates pki tickets in a data bag
* Add example recipes to configure a client/remote_api server which allow
external command execution
* Allow to set command_endpoint as var and not only as string


###v2.7.1

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

###v2.6.9

* Attribute `default['icinga2']['user_defined_objects_d']` is deprecated. For User defined configuration directories,
use `Array` attribute `default['icinga2']['user_defined_objects_dir']` instead.

###v2.0.1

* icinga web2 uri updated to `/icingaweb2`

* epel repository is by default enabled for rhel platform family except amazon platform


###v0.10.1

* Deprecated node *features* attribute and recipe `icinga2::server_features` in favour of LWRP `feature`


###v0.7.0

* LWRP `environment` now generates different conf file with zone name if resource attribute `zone` is defined

  **file name:**

  file name without zone: `host_#{environment}_#{resource_name}.conf`

  file name with zone: `host_#{environment}_#{zone}_#{resource_name}.conf`

  >> Note: Cookbook version prior to v0.7.0 users must delete
    configuration file `host_#{environment}.conf` manually if
    `zone` attribute is defined.

  >> Note: Cookbook version prior to v2.7.1 users must delete
    configuration files `host_#{environment}.conf / host_#{environment}_#{zone}.conf` manually.

## Cookbook Dependencies

* `ulimit` cookbook
* `apache2` cookbook
* `yum` cookbook
* `yum-epel` cookbook
* `apt` cookbook
* `pnp4nagios` cookbook



## Recipes

- `icinga2::default`     	- does not do anything, used for LWRP usage

- `icinga2::client`     	- does not do anything, used for LWRP usage

- `icinga2::client_os_package`     	- install icinga2 client os packages

- `icinga2::core_config`     	- icinga2 common directory and file resources

- `icinga2::core_install`     	- setup icinga2 repository and install icinga2 package

- `icinga2::server`  		- install & configure icinga2 server with default icinga Objects

- `icinga2::server_apache`		- manages apache and icinga2 classic ui / web / web2 vhost using `apache2` cookbook

- `icinga2::server_classic_ui`      - configures icinga2 classic ui

- `icinga2::server_config`      - icinga2 server specific configuration

- `icinga2::server_ido_schema`      - load icinga2 ido db schema

- `icinga2::server_object_host`   	- creates icinga2 `generic-host` `Host` template

- `icinga2::server_object_notificationcommand`   - creates icinga2 default `NotificationCommand` objects

- `icinga2::server_object_service`   		- creates icinga2 default`generic-service` `Service`  templates

- `icinga2::server_object_timeperiod`   	- creates icinga2 default `TimePeriod` objects

- `icinga2::server_object_user`   			- creates icinga2 `generic-user` `User` template and `icingaadmin` `User` object

- `icinga2::server_object_usergroup`   	- creates icinga2 `icingaadmins` `UserGroup` object

- `icinga2::server_objects`       - manages icinga2 default objects/templates objects if `node['icinga2']['disable_conf_d']` is set in which case `conf.d` objects config is not included in `icinga2.conf` and objects are created using LWRP

- `icinga2::server_os_packages`       - install icinga2 server os packages

- `icinga2::server_pnp`       - configures pnp4nagios for icinga2

- `icinga2::server_web2`      - configures icingaweb2

## Attributes

- `icinga2::default` 			- icinga2 default attributes

- `icinga2::repo`				- icinga2 yum/apt repositories attributes

- `icinga2::server_apache` - apache2 attributes

- `icinga2::server_classic_ui` - icinga2 server classic ui attributes

- `icinga2::server_constants`	- icinga2 server constants attributes

- `icinga2::server_ido`		- icinga2 server ido db attributes

- `icinga2::server_objects`		- icinga2 server objects attributes

- `icinga2::server_web2`		- icingaweb2 attributes



## Icinga2 Server Setup Recipes

### Disable Default Configuration Directory

If you are using this cookbook to manage `icinga2` configuration, set `default['icinga2']['disable_conf_d']` to `true`.

Cookbook generated configuration files using LWRP are created under directory `default['icinga2']['objects_dir']`.

>> `default['icinga2']['disable_conf_d']` default value is set to `true`.


### How to Install and Configure Icinga2 Server without UI

- add recipe `icinga2::server` to your run_list


### How to Install and Configure Icinga2 Server with ClassicUI

- set node['icinga2']['classic_ui']['enable'] = true
- add recipe `icinga2::server` to your run_list


### How to Install and Configure Icinga2 Server with ClassicUI and PNP

- set node['icinga2']['classic_ui']['enable'] = true
- set node['icinga2']['pnp'] = true
- add recipe `icinga2::server` to your run_list


### How to Install and Configure Icinga2 Server with Icingaweb2 UI

- set node['icinga2']['web2']['enable'] = true
- add recipe `icinga2::server` to your run_list


## Icinga2 Client Setup Recipe

To install and configure `icinga2` for client add recipe `icinga2::client` to agent run_list



## Icinga2 Web / Classic UI engine

Currently this cookbook only supports `Apache` as Web engine and configuration is managed by cookbook `apache2`.

Web engine is configurable by node attribute `node['icinga2']['web_engine']`, defaults to `apache`.



## Icinga2 Classic UI

Icinga2 Classic UI is disabled by default and can be enabled by attribute `node['icinga2']['classic_ui']['enable']`.


**How to add users for icinga2 Classic UI**

Icinga2 Classic UI users is controlled by node Hash attribute `node['icinga2']['classic_ui']['users']`. This attribute accepts a `Hash` of `username => htpasswd(passwd)`, so that password is not available in plain text.

By default `icingaadmin` user is added with password `icingaadmin`:

	default['icinga2']['classic_ui']['users'] = {
	  'icingaadmin' => '$apr1$MZtKRLAy$AV9OiJ.V/mI9g30bHn9ol1'
	}

Override it if required in wrapper cookbook or role or environment.

To add more users for icinga2 Classic UI auth, add new users to Hash attribute in the same way `icingaadmin` user is added

	default['icinga2']['classic_ui']['users']['user_name'] = '$apr1$MZtKRLAy$AV9OiJ.V/mI9g30bHn9ol1'

**Icinga2 Classic UI Authorization**


Icinga2 Classic UI User authorization is managed by below node Array attributes:

	node['icinga2']['classic_ui']['authorized_for_system_information']
	node['icinga2']['classic_ui']['authorized_for_configuration_information']
	node['icinga2']['classic_ui']['authorized_for_full_command_resolution']
	node['icinga2']['classic_ui']['authorized_for_system_commands']
	node['icinga2']['classic_ui']['authorized_for_all_services']
	node['icinga2']['classic_ui']['authorized_for_all_hosts']
	node['icinga2']['classic_ui']['authorized_for_all_service_commands']
	node['icinga2']['classic_ui']['authorized_for_all_host_commands']

By simply adding users to above attributes will provide necessary access to the UI.



**How to add a guest user**

To add a guest user without any admin privileges, first add a `guest` user (with password `guest`)

	default['icinga2']['classic_ui']['users']['guest'] = '$apr1$cA/eVUgT$aIoWUPwV5uONJoYslb7lg0'

Then authorise `guest` user to view `Host/Service` status

	node['icinga2']['classic_ui']['authorized_for_all_services'] = %w(icingaadmin guest)
	node['icinga2']['classic_ui']['authorized_for_all_hosts'] = %w(icingaadmin guest)



**How to add an admin user**

To make a user `admin`, add the user to below node attributes:

	node['icinga2']['classic_ui']['authorized_for_system_information']
	node['icinga2']['classic_ui']['authorized_for_configuration_information']
	node['icinga2']['classic_ui']['authorized_for_full_command_resolution']
	node['icinga2']['classic_ui']['authorized_for_system_commands']
	node['icinga2']['classic_ui']['authorized_for_all_services']
	node['icinga2']['classic_ui']['authorized_for_all_hosts']
	node['icinga2']['classic_ui']['authorized_for_all_service_commands']
	node['icinga2']['classic_ui']['authorized_for_all_host_commands']


## Icinga2 Server IDO Schema Load

Icinga2 IDO setup & feature is disabled by default. It can be enabled by configuring node attribute `node['icinga2']['ido']['load_schema']`.

Recipe `icinga::server_ido_schema` only create DB schema, it does not create database or user or grants etc.

IDO schema files are stored by default under directory `/usr/share/icinga2-ido-mysql` and `/usr/share/icinga2-ido-pgsql`.

Icinga2 IDO type is configurable by node attribute `node['icinga2']['ido']['type']`, which can be configured to `mysql` or `pgsql`.

>> ido pgsql schema upload is not fully tested, please open an issue if encounter any problem.

Loading Schema require `mysql` or `psql` client, currently cookbook can install `mysql` client is `default['icinga2']['ido']['install_mysql_client']` is true.


## Icinga Web2 Setup

Icingaweb2 is not enabled by default. It can be enabled by configuring node attribute `node['icinga2']['web2']['enable']`.

Icingaweb2 can also be enabled by including recipe `icinga2::server_web2` to node `run_list`.

Recipe `icinga::server_web2` configures below items.

- create config directory `/etc/icingaweb2`
- create token file `/etc/icingaweb2/setup.token`
- create log directory `/var/log/icingaweb2`

Rest of the configuration can be completed by browsing icingaweb2 Web UI `http://server/icingaweb`. More configuration management will be added soon.


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


	icinga2_environment 'UserDefinedEnvironment' do
	  import node['icinga2']['server']['object']['host']['import']
	  environment 'production'
	  check_interval '1m'
	  retry_interval '10s'
	  max_check_attempts 3
	  action_url '/pnp4nagios/graph?host=$HOSTNAME$&srv=_HOST_'
	  env_resources :nodes => {:fqdn => {attrs}, :fqdn => {attrs}}
	end


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
  add_ohai_vars 'hardware' => %w(dmi system manufacturer)
end
```

It will add a custom var `vars.hardware` to environemnt Host objects.


## Icinga2 User Defined Objects / Configuration


Attribute `node['icinga2']['user_defined_objects_dir']` manages user defined configuration directories location.

Directories will be created under `/etc/icinga2/` and also included in `icinga2.conf`.


## LWRP Examples

Different LWRP usage examples are added to `examples` directory.

To configure icinga2 server, check `examples/icinga2_server` directory. More examples will be added as we go.


## LWRP 'assign where' and 'ignore where' statements

**assign where (icinga) == assign_where (LWRP)**

**ignore where (icinga) == ignore_where (LWRP)**

`assign where` statements are defined as a LWRP resource `Array` attribute -`assign_where`. Each array element is treated as a different `assign where` statement and LWRP creates a separate statement.

e.g.

	assign_where ['host.address',
	  'host.vars.nrpe && host.vars.enable_check',
	  'host.vars.application == "redis"'
	]

Above LWRP resource will be applied to an `Object` as shown below:

	assign where host.address
	assign where host.vars.nrpe && host.vars.enable_check
	assign where host.vars.application == "redis"


Similarly, `ignore where` statements are created using LWRP resource `Array` attribute `ignore_where`.



## icinga2 LWRP Resources

Currently icinga2 cookbook supports below Objects LWRP Resources:

- icinga2_apilistener
- icinga2_applynotification
- icinga2_applyservice
- icinga2_checkcommand
- icinga2_endpoint
- icinga2_envendpoint
- icinga2_envhostgroup
- icinga2_envzone
- icinga2_environment
- icinga2_eventcommand
- icinga2_externalcommandlistener
- icinga2_feature
- icinga2_gelfwriter
- icinga2_graphitewriter
- icinga2_host
- icinga2_hostgroup
- icinga2_idomysqlconnection
- icinga2_idopgsqlconnection
- icinga2_notification
- icinga2_notificationcommand
- icinga2_scheduleddowntime
- icinga2_script
- icinga2_service
- icinga2_servicegroup
- icinga2_sysloglogger
- icinga2_timeperiod
- icinga2_user
- icinga2_usergroup
- icinga2_zone
- icinga2_livestatuslistener
- icinga2_statusdatawriter
- icinga2_compatlogger
- icinga2_checkresultreader
- icinga2_notificationcomponent
- icinga2_filelogger
- icinga2_perfdatawriter


Note:

* Few of LWRP attributes which are required to create an icinga2 Object are not declared `:required => true` in LWRP in favour of creating icinga2 Object template.

* Same LWRP resource used to create icinga2 `Object`, can also be used to create icinga2 `Template` as well.

* Few of LWRP resource attributes which refers to icinga2 `constants` or can refer to `constants` are treated as literal `String`. It means they will not be transformed into ruby `String` by LWRP while creating configuration file.

e.g.

Below attribute definition generate correct syntax for `ApiListener` LWRP attribute `cert_path`:

	    cert_path 'SysConf + "/icinga2/pki/" + NodeName + ".crt"'

	    will transform to:

    	cert_path SysConf + "/icinga2/pki/" + NodeName + ".crt"


While below attribute definition generate incorrect syntax:

		cert_path 'SysConf + /icinga2/pki/ + NodeName + .crt'

		will transform to

    	cert_path SysConf + /icinga2/pki/ + NodeName + .crt


## icinga2 LWRP Resources Generated Object/Template File


**LWRP Resource Object Config File Location**

Icinga2 `Object` created by LWRP are stored under a separate directory `objects.d`. Directory name is configurable by node attribute `node['icinga2']['objects_d']`.

This directory is created under icinga2 config directory `node['icinga2']['conf_dir']`.

**LWRP Resource Object/Template Config File Name Convention**

A LWRP generated icinga2 `Object's` are stored into a single file. It means each LWRP has its own conf file.

As few of LWRP can create an `Object` and `Template`, below conf file name convention is followed through out LWRP resources.

	Object conf file : "#{LWRP_NAME}.conf".
	Template conf file : "#{LWRP_NAME}_template.conf".


e.g.

	LWRP `icinga2_host` object resources will create icinga2
	`Host` objects conf file - /etc/icinga2/objects.d/host.conf

	LWRP `icinga2_service` object resources will create icinga2
	`Service` objects conf file - /etc/icinga2/objects.d/service.conf

	LWRP `icinga2_service` template resources will create icinga2
	`Service` templates conf file - /etc/icinga2/objects.d/service_template.conf

	LWRP `icinga2_applyservice` resources will create icinga2
	`apply Service` conf file - /etc/icinga2/objects.d/applyservice.conf

	and so on ..


All LWRP generated icinga2 object/template/apply conf files are kept in a single directory and managed separately.


## Default icinga2 /etc/icinga2/{conf.d,zones.conf}


As this cookbook supplies almost all necessary LWRP for icinga2 feature, object, template etc. it is a good practice and safe to say to use LWRP instead of managing configuration `/etc/icinga2/conf.d` or `/etc/icinga2/zones.conf` default configuration files.

Note: Default configuration files managed by cookbook:

* /etc/icinga2/constants.conf
* /etc/icinga2/icinga2.conf
* /etc/icinga2/init.conf

`icinga2.conf` no longer includes `zones.conf` in favour of LWRP.


## LWRP icinga2_environment

As mentioned in a section above, instead of creating `Host` objects for each chef node, using LWRP `environment` `Host` objects can easily be created for all chef nodes for a chef environment.

LWRP resource attributes are common for all the `Host`. It may be required to define or override attribute for few specific `Host` objects, but it is not yet incorporated or foreseen any usage at this point which might change over time.


**Turn Off Monitoring for a Chef Node**

To turn off monitoring for a chef node, simply set attribute - `node['monitoring_off']`.

If this attribute is set for a chef node, LWRP `environment` will simply ignore that node.


**LWRP generated config file**

There are two files generated by LWRP `environment`:

1. if zone is not defined - `host_#{*environment*}_#{*resource_name*}.conf`

2. if zone is defined: `host_#{environment*}_#{*zone*}_#{*resource_name*}.conf`

>> Note: Cookbook version prior to v0.7.0 might require to manually delete configuration file `host_#{*environment*}.conf` if zone is defined.
>> Note: Cookbook version prior to v2.7.1 might require to manually delete configuration file `host_#{*environment*}.conf / host_#{*environment*}_#{*zone*}.conf`.

**LWRP example**

	icinga2_environment 'SingaporeDevelopment' do
	  import node['icinga2']['server']['object']['host']['import']
	  environment 'development'
	  limit_region true
	  ignore_resolv_error true
	  enable_cluster_hostgroup true
	  enable_application_hostgroup true
	  cluster_attribute 'flock'
	  application_attribute 'application'
	  check_interval '1m'
	  retry_interval '10s'
	  max_check_attempts 3
	  action_url '/pnp4nagios/graph?host=$HOSTNAME$&srv=_HOST_'
	end


Above LWRP resource will create `Host` objects for a chef environment nodes for a given `search_pattern` and other filter.


**LWRP Options**


- *action* (optional)			- default :create, options: :create, :delete, :reload
- *environment* (required, String)		- chef environment name
- *cookbook* (optional, String)		- default icinga2, chef cookbook name for template
- *template* (optional, String)		- default object.environment.conf.erb, chef template name
- *search_pattern* (optional, String)	- chef search pattern for given environment
- *env_resources* (optional, Hash)	- user provided Hash for environment nodes and host groups etc., overrides default chef search nodes inventory
- *cluster_attribute* (optional, String)	-  chef node cluster attribute to create hostgroup and `Host` vars
- *application_attribute* (optional, String) - chef node application attribute to create hostgroup and `Host` vars
- *enable_cluster_hostgroup* (optional, TrueClass/FalseClass)	- whether to create `HostGroup` objects for chef node cluster's
- *enable_application_hostgroup* (optional, TrueClass/FalseClass)	- whether to create `HostGroup` objects for chef node application's
- *enable_role_hostgroup* (optional, TrueClass/FalseClass)	- whether to create `HostGroup` objects for chef node run_list role
- *host_display_name_attr* (optional, String)	- whether to use `hostname` or `fqdn` or `name` (chef node name) for Host Object attribute `display_name`, options: hostname fqdn name
- *use_fqdn_resolv* (optional, TrueClass/FalseClass)	- whether to use DNS FQDN resolved address for `Host` object attribute `address`
- *failover_fqdn_address* (optional, TrueClass/FalseClass)	- whether to use chef node attribute `node['ipaddress']` if failed to resolve node FQDN
- *ignore_resolv_error* (optional, TrueClass/FalseClass)	- whether to ignore node FQDN resolve error
- *ignore_node_error* (optional, TrueClass/FalseClass)	- whether to ignore node if failed to determine `node[]'chef_environment']` or `node['fqdn']` or `node['hostname']`
- <del> *exclude_recipes* (optional, Array)	- exclude chef node if `run_list` matches recipe, not yet tested </del>
- <del> *exclude_roles* (optional, Array)	- exclude chef node if `run_list` matches role, not yet tested </del>
- *env_custom_vars* (optional, Hash)	- add `Host` object custom vars to all chef node
- *limit_region* (optional, TrueClass/FalseClass)	- whether to limit chef node to chef server region, currently tested for Amazon EC2, e.g. a icinga2 server located in region `us-east-1` will only collect nodes located in `us-east-`` region
- *server_region* (optional, String)	- icinga2 server region can be overridden if cloud provider is not supported by the cookbook using this attribute
- *add_cloud_custom_vars* (optional, TrueClass/FalseClass)	- whether to add cloud attributes, currently supports amazon ec2, e.g. instance id, vpc subnet etc.
- *add_inet_custom_vars* (optional, TrueClass/FalseClass)	- whether to add inet ip address custom vars to Host objects
- *add_node_vars* (optional, Hash)	- add node attributes to custom vars, e.g. `add_ohai_vars 'hardware' => %w(dmi system manufacturer)` will add a custom var hardware with value of node attribute `node['dmi']['system']['manufacturer']`
- *env_filter_node_vars* (optional, Hash)	- filter or match chef nodes for a given `Hash` attribute key value pairs
- *env_skip_node_vars* (optional, Hash)	- ignore chef nodes for a given `Hash` attribute key value pairs
- *import* (optional, String)	- icinga `Host` object import template attribute
- *check_command* (optional, String)	- icinga `Host` object attribute `check_command`
- *max_check_attempts* (optional, Integer)	- icinga `Host` object attribute `max_check_attempts`
- *check_period* (optional, String)	- icinga `Host` object attribute `check_period`
- *notification_period* (optional, String)	- icinga `Host` object attribute `notification_period`
- *check_interval* (optional, String/Integer)	- icinga `Host` object attribute `check_interval`
- *retry_interval* (optional, Integer)	- icinga `Host` object attribute `retry_interval`
- *enable_notifications* (optional, TrueClass/FalseClass)	- icinga `Host` object attribute `enable_notifications`
- *enable_active_checks* (optional, TrueClass/FalseClass)	- icinga `Host` object attribute `enable_active_checks`
- *enable_passive_checks* (optional, TrueClass/FalseClass)	- icinga `Host` object attribute `enable_passive_checks`
- *enable_passive_checks* (optional, TrueClass/FalseClass)	- icinga `Host` object attribute `enable_passive_checks`
- *enable_event_handler* (optional, TrueClass/FalseClass)	- icinga `Host` object attribute `enable_event_handler`
- *enable_flapping* (optional, TrueClass/FalseClass)	- icinga `Host` object attribute `enable_flapping`
- *enable_perfdata* (optional, TrueClass/FalseClass)	- icinga `Host` object attribute `enable_perfdata`
- *event_command* (optional, String)	- icinga `Host` object attribute `event_command`
- *flapping_threshold* (optional, String)	- icinga `Host` object attribute `flapping_threshold`
- *volatile* (optional, , TrueClass/FalseClass)	- icinga `Host` object attribute `volatile`
- *zone* (optional, String)	- icinga `Host` object attribute `zone`
- *command_endpoint* (optional, String)	- icinga `Host` object attribute `command_endpoint`
- *notes* (optional, String)	- icinga `Host` object attribute `notes`
- *notes_url* (optional, String)	- icinga `Host` object attribute `notes_url`
- *action_url* (optional, String)	- icinga `Host` object attribute `action_url`
- *icon_image* (optional, String)	- icinga `Host` object attribute `icon_image`
- *icon_image_alt* (optional, String)	- icinga `Host` object attribute `icon_image_alt`
- *endpoint_port* (optional, Integer)	- icinga `Endpoint` object attribute `port`
- *endpoint_log_duration* (optional, String)	- icinga `Endpoint` object attribute `log_duration`
- *zone_parent* (optional, String)	- icinga `Zone` object attribute `parent`


Note: Few of LWRP resource attributes has default value, please check LWRP resource until information is added here.


## LWRP icinga2_envhostgroup

LWRP `envhostgroup` creates an icinga `Hostgroup` object for LWRP `environment` host groups.

An `environment` host groups are evaluated at compile time, hence it conflicts with LWRP `hostgroup` resources. To avoid the conflict, LWRP `envhostgroup` resources are created in a separate object file for an environment.


**LWRP Environment HostGroup example**

	icinga2_envhostgroup 'envhostgroup' do
	  environment environment_name
	  groups %w(group)
	end

Above LWRP resource will create `HostGroup` for a chef environment.


**LWRP Options**

- *action* (optional)	                   - default :enable, options: :enable, :disable
- *environment* (name_attribute, String)   - chef environment name
- *groups* (optional, Array)	           - host group names

Note: This LWRP resource is only meant for LWRP `environment` and not to be used for custom resources.


## LWRP icinga2_envendpoint

LWRP `envendpoint` creates an icinga `Endpoint` object for LWRP `environment` endpoints.

An `environment` endpoints are evaluated at compile time, hence it conflicts with LWRP `endpoint` resources. To avoid the conflict, LWRP `envendpoint` resources are created in a separate object file for an environment.


**LWRP Environment Endpoint example**

    icinga2_envendpoint 'envendpoint' do
      endpoints %w(endpoint)
      port 5665
      environment environment_name
      log_duration '1d'
    end

Above LWRP resource will create `Endpoint` for a chef environment.


**LWRP Options**

- *action* (optional)	                    - default :enable, options: :enable, :disable
- *environment* (name_attribute, String)	- chef environment name
- *endpoints* (optional, Array)	            - endpoint names
- *port* (optional, Integer)	            - default 5665, The service name/port of the remote Icinga 2 instance
- *log_duration* (optional, String)	        - Duration for keeping replay logs on connection loss.

Note: This LWRP resource is only meant for LWRP `environment` and not to be used for custom resources.


## LWRP icinga2_envzone

LWRP `envzone` creates an icinga `Zone` object for LWRP `environment` zones.

An `environment` zones are evaluated at compile time, hence it conflicts with LWRP `zone` resources. To avoid the conflict, LWRP `envzone` resources are created in a separate object file for an environment.


**LWRP Environment Zone example**

    icinga2_envzone 'envzone' do
      zones %w(zone)
      parent 'master'
      environment environment_name
    end

Above LWRP resource will create `Zone` for a chef environment.


**LWRP Options**

- *action* (optional)	                    - default :enable, options: :enable, :disable
- *environment* (name_attribute, String)	- chef environment name
- *zones* (optional, Array)                 - zone names
- *parent* (optional, String)	            - The name of the parent zone.

Note: This LWRP resource is only meant for LWRP `environment` and not to be used for custom resources.


## LWRP icinga2_host


Unlike LWRP `environment`, LWRP `host` creates an icinga `Host` object or template.

LWRP `host` can be useful for servers not managed by Chef or to monitor Cloud Services like Amazon Elastic Cache or Amazon RDS etc.

**LWRP Host Object example**

	icinga2_host 'redis-ec.abcdef.0001.apse1.cache.amazonaws.com' do
	  display_name 'Production Redis Server'
	  address 'redis-ec.abcdef.0001.apse1.cache.amazonaws.com'
	  custom_vars :check_tcp_ports => %w(6379), :application => 'redis', :environment => 'production', :cluster_name => 'prodredis0001'
	end


Above LWRP resource will create an icinga `Host` object.


**LWRP Host Template example**

	icinga2_host 'generic-host' do
	  template true
	  max_check_attempts 5
	  check_interval '1m'
	  retry_interval '30s'
	  check_command 'hostalive'
	end

Above LWRP resource will create an icinga `Host` template - `generic-host`.


**LWRP Options**


- *action* (optional)			- default :create, options: :create, :delete, :reload
- *display_name* (optional, String)	- icinga `Host` object import template attribute
- *import* (optional, String)	- icinga `Host` object import template attribute
- *address* (optional, String)	- icinga `Host` object import template attribute
- *address6* (optional, String)	- icinga `Host` object import template attribute
- *groups* (optional, Array)	- icinga `Host` object import template attribute
- *check_command* (optional, String)	- icinga `Host` object attribute `check_command`
- *max_check_attempts* (optional, Integer)	- icinga `Host` object attribute `max_check_attempts`
- *check_period* (optional, String)	- icinga `Host` object attribute `check_period`
- *notification_period* (optional, String)	- icinga `Host` object attribute `notification_period`
- *check_interval* (optional, String/Integer)	- icinga `Host` object attribute `check_interval`
- *retry_interval* (optional, String/Integer)	- icinga `Host` object attribute `retry_interval`
- *enable_notifications* (optional, TrueClass/FalseClass)	- icinga `Host` object attribute `enable_notifications`
- *enable_active_checks* (optional, TrueClass/FalseClass)	- icinga `Host` object attribute `enable_active_checks`
- *enable_passive_checks* (optional, TrueClass/FalseClass)	- icinga `Host` object attribute `enable_passive_checks`
- *enable_passive_checks* (optional, TrueClass/FalseClass)	- icinga `Host` object attribute `enable_passive_checks`
- *enable_event_handler* (optional, TrueClass/FalseClass)	- icinga `Host` object attribute `enable_event_handler`
- *enable_flapping* (optional, TrueClass/FalseClass)	- icinga `Host` object attribute `enable_flapping`
- *enable_perfdata* (optional, TrueClass/FalseClass)	- icinga `Host` object attribute `enable_perfdata`
- *event_command* (optional, String)	- icinga `Host` object attribute `event_command`
- *flapping_threshold* (optional, String)	- icinga `Host` object attribute `flapping_threshold`
- *volatile* (optional, , TrueClass/FalseClass)	- icinga `Host` object attribute `volatile`
- *zone* (optional, String)	- icinga `Host` object attribute `zone`
- *command_endpoint* (optional, String)	- icinga `Host` object attribute `command_endpoint`
- *notes* (optional, String)	- icinga `Host` object attribute `notes`
- *notes_url* (optional, String)	- icinga `Host` object attribute `notes_url`
- *action_url* (optional, String)	- icinga `Host` object attribute `action_url`
- *icon_image* (optional, String)	- icinga `Host` object attribute `icon_image`
- *icon_image_alt* (optional, String)	- icinga `Host` object attribute `icon_image_alt`
- *custom_vars* (optional, String)	- icinga `Host` object attribute `vars`
- *template* (optional, TrueClass/FalseClass)	- whether to create a `Host` template


## LWRP icinga2_hostgroup

LWRP `hostgroup` creates an icinga `HostGroup` object.


**LWRP HostGroup example**

	icinga2_hostgroup 'hostgroup_name' do
	  display_name 'Host Group'
	  groups ['othergroup']
	  assign_where ['"hostgroup_name" in host.vars.hostgroups']
	  ignore_where ['"hostgroup_name" in host.vars.hostgroups']
	end

Above LWRP resource will create an icinga `HostGroup` object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *display_name* (optional, String)	- icinga `HostGroup` attribute `display_name`
- *groups* (optional, Array)	- icinga `HostGroup` attribute `groups`
- *assign_where* (optional, Array)	 - an array of `assign where` statements
- *ignore_where* (optional, Array)	 - an array of `ignore where` statements


## LWRP icinga2_service


LWRP `service` creates an icinga `Service` object or template.


**LWRP Service Object example**

	icinga2_service 'redis-ec.abcdef.0001.apse1.cache.amazonaws.com_service_check' do
	  display_name 'Production Redis Service Check'
	  host_name 'redis-ec.abcdef.0001.apse1.cache.amazonaws.com'
	  check_command 'tcp'
	  custom_vars :tcp_port => 6379
	end


Above LWRP resource will create an icinga `Service` object for a host tcp port check.


**LWRP Service Template example**

	icinga2_service 'generic-service' do
	  template true
	  max_check_attempts 5
	  check_interval '1m'
	  retry_interval '30s'
	end

Above LWRP resource will create an icinga `Service` template object for a `generic-service` `Service`.


**LWRP Options**


- *action* (optional)	- default :create, options: :create, :delete, :reload
- *display_name* (optional)	- icinga `Service` object attribute `display_name`
- *import* (optional)	- icinga `Service` object attribute `import`
- *host_name* (optional)	- icinga `Service` object attribute `host_name`
- *groups* (optional)	- icinga `Service` object attribute `groups`
- *check_command* (optional)	- icinga `Service` object attribute `check_command`
- *max_check_attempts* (optional)	- icinga `Service` object attribute `max_check_attempts`
- *check_period* (optional)	- icinga `Service` object attribute `check_period`
- *notification_period* (optional)	- icinga `Service` object attribute `notification_period`
- *check_interval* (optional)	- icinga `Service` object attribute `check_interval`
- *retry_interval* (optional)	- icinga `Service` object attribute `retry_interval`
- *enable_notifications* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `enable_notifications`
- *enable_active_checks* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `enable_active_checks`
- *enable_passive_checks* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `enable_passive_checks`
- *enable_passive_checks* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `enable_passive_checks`
- *enable_event_handler* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `enable_event_handler`
- *enable_flapping* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `enable_flapping`
- *enable_perfdata* (optional)	- icinga `Service` object attribute `enable_perfdata`
- *event_command* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `event_command`
- *flapping_threshold* (optional, String)	- icinga `Service` object attribute `flapping_threshold`
- *volatile* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `volatile`
- *zone* (optional, String)	- icinga `Service` object attribute `zone`
- *command_endpoint* (optional, String)	- icinga `Service` object attribute `command_endpoint`
- *notes* (optional, String)	- icinga `Service` object attribute `notes`
- *notes_url* (optional, String)	- icinga `Service` object attribute `notes_url`
- *action_url* (optional, String)	- icinga `Service` object attribute `action_url`
- *icon_image* (optional, String)	- icinga `Service` object attribute `icon_image`
- *icon_image_alt* (optional, String)	- icinga `Service` object attribute `icon_image_alt`
- *custom_vars* (optional, Hash)	- icinga `Service` object attribute `vars`
- *template* (optional, TrueClass/FalseClass)	- whether to create a `Service` template


## LWRP icinga2_applyservice

LWRP `service` creates an icinga `Service` object or template.


**LWRP Apply Service Object example**

	icinga2_applyservice 'nrpe_check_load' do
	  display_name 'CPU Average Load'
	  import 'generic-service'
	  check_command 'nrpe'
	  custom_vars :nrpe_command => 'check_load'
	  assign_where ['host.vars.nrpe']
	  check_interval '1m'
	  retry_interval '15s'
	  max_check_attempts 3
	  action_url '/pnp4nagios/graph?host=$HOSTNAME$&srv=$SERVICEDESC$'
	end

Above LWRP resource will apply an icinga `Service` object to all `Hosts` with custom vars `host.vars.nrpe`.

**LWRP Apply Service For Object example**

	icinga2_applyservice 'areca' do
    set 'areca => config in host.vars.areca'
	  display_name '"areca raidset" + areca'
	  import 'generic-service'
	  check_command 'check_snmp'
	  assign_where ['"areca" in host.vars.enabled_services']
	  merge_vars ['config']
	  check_interval '5m'
	  retry_interval '3m'
	  max_check_attempts 2
	end

Above LWRP resource will apply an icinga `Service` object with a Service for set (also called hash or dictionary) to all `Hosts` with custom vars `host.vars.enabled_services` including 'areca'. It will also merge the values in `config` into the `Service` object.


**LWRP Options**


- *action* (optional)	- default :create, options: :create, :delete, :reload
- *display_name* (optional, String)	- icinga `Service` object attribute `display_name`
- *set* (optional, String) - gives a set (hash/dictionary) to the icinga `service` object
- *import* (optional, String)	- icinga `Service` object attribute `import`
- *host_name* (optional, String)	- icinga `Service` object attribute `host_name`
- *groups* (optional, Array)	- icinga `Service` object attribute `groups`
- *check_command* (optional, String)	- icinga `Service` object attribute `check_command`
- *max_check_attempts* (optional, Integer)	- icinga `Service` object attribute `max_check_attempts`
- *check_period* (optional, String)	- icinga `Service` object attribute `check_period`
- *notification_period* (optional, String)	- icinga `Service` object attribute `notification_period`
- *check_interval* (optional, String/Integer)	- icinga `Service` object attribute `check_interval`
- *retry_interval* (optional, String/Integer)	- icinga `Service` object attribute `retry_interval`
- *enable_notifications* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `enable_notifications`
- *enable_active_checks* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `enable_active_checks`
- *enable_passive_checks* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `enable_passive_checks`
- *enable_passive_checks* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `enable_passive_checks`
- *enable_event_handler* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `enable_event_handler`
- *enable_flapping* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `enable_flapping`
- *enable_perfdata* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `enable_perfdata`
- *event_command* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `event_command`
- *flapping_threshold* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `flapping_threshold`
- *volatile* (optional, TrueClass/FalseClass)	- icinga `Service` object attribute `volatile`
- *zone* (optional, String)	- icinga `Service` object attribute `zone`
- *command_endpoint* (optional, String)	- icinga `Service` object attribute `command_endpoint`
- *notes* (optional, String)	- icinga `Service` object attribute `notes`
- *notes_url* (optional, String)	- icinga `Service` object attribute `notes_url`
- *action_url* (optional, String)	- icinga `Service` object attribute `action_url`
- *icon_image* (optional, String)	- icinga `Service` object attribute `icon_image`
- *icon_image_alt* (optional, String)	- icinga `Service` object attribute `icon_image_alt`
- *custom_vars* (optional, Hash)	- icinga `Service` object attribute `vars`
- *merge_vars* (optional, Array)	- Merge vars from each member of a set into icinga `Service` object attribute `vars`
- *assign_where* (optional, Array)	 - an array of `assign where` statements
- *ignore_where* (optional, Array)	 - an array of `ignore where` statements


## LWRP icinga2_servicegroup

LWRP `servicegroup` creates an icinga `ServiceGroup` object.


**LWRP ServiceGroup example**

	icinga2_servicegroup 'servicegroup_name' do
	  display_name 'Service Group'
	  groups ['othergroup']
	  assign_where ['"servicegroup_name" in host.vars.servicegroups']
	  ignore_where ['"servicegroup_name" in host.vars.servicegroups']
	end

Above LWRP resource will create an icinga `ServiceGroup` object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *display_name* (optional, String)	- icinga `ServiceGroup` attribute `display_name`
- *groups* (optional, Array)	- icinga `ServiceGroup` attribute `groups`
- *assign_where* (optional, Array)	 - an array of `assign where` statements
- *ignore_where* (optional, Array)	 - an array of `ignore where` statements


## LWRP icinga2_feature

LWRP `feature` enable or disable an icinga `Feature`.


**LWRP Feature enable example**

	icinga2_feature 'feature'

Above LWRP resource will enable an icinga `Feature`.


**LWRP Feature disable example**

	icinga2_feature 'feature' do
	  action :disable
	end

Above LWRP resource will disable an icinga `Feature`.


**LWRP Options**

- *name*(name_attribute)	- icinga2 feature name
- *action* (optional)	- default :enable, options: :enable, :disable


## LWRP icinga2_user

LWRP `user` creates an icinga `User` object.


**LWRP User Object example**

	icinga2_user 'user_name' do
	  import 'generic-user'
	  enable_notifications true
	  states %w(OK Warning Critical Unknown Up Down)
	  types %w(DowntimeStart DowntimeEnd DowntimeRemoved Custom Acknowledgement Problem Recovery FlappingStart FlappingEnd)
	  display_name 'User Info'
	  groups %w(usergroup)
	  email 'user@domain'
	end


Above LWRP resource will create an icinga `User` object.

**LWRP User Template example**

	icinga2_user 'generic-user' do
	  template true
	end

Above LWRP resource will create an icinga `User` template.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *display_name* (optional, String)	- icinga `User` attribute `display_name`
- *import* (optional, String)	- icinga `User` attribute `import`
- *groups* (optional, Array)	- icinga `User` attribute `groups`
- *email* (optional, String)	- icinga `User` attribute `email`
- *pager* (optional, String)	- icinga `User` attribute `pager`
- *period* (optional, String)	- icinga `User` attribute `period`
- *states* (optional, Array)	- icinga `User` attribute `states`
- *types* (optional, Array)	- icinga `User` attribute `types`
- *zone* (optional, String)	- icinga `User` attribute `zone`
- *custom_vars* (optional, Hash)	- icinga `User` attribute `vars`
- *enable_notifications* (optional, TrueClass/FalseClass)	- icinga `User` attribute `enable_notifications`
- *template* (optional, TrueClass/FalseClass)	- whether to create a `User` template


## LWRP icinga2_usergroup

LWRP `usergroup` creates an icinga `UserGroup` object.


**LWRP UserGroup example**

	icinga2_usergroup 'usergroup_name' do
	  display_name 'User Group'
	  groups ['usergroup']
	  zone 'zone_name'
    assign_where ['assign where statement']
    ignore_where ['ignore where statement']
	end

Above LWRP resource will create an icinga `UserGroup` object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *display_name* (optional, String)	- icinga `UserGroup` attribute `display_name`
- *groups* (optional, Array)	- icinga `UserGroup` attribute `groups`
- *zone* (optional, String)	- icinga `UserGroup` attribute `zone`
- *assign_where* (optional, Array)   - an array of `assign where` statements
- *ignore_where* (optional, Array)   - an array of `ignore where` statements


## LWRP icinga2_zone

LWRP `zone` creates an icinga `Zone` object.


**LWRP Zone example**

	icinga2_zone 'zone' do
	  endpoints %w(endpoint)
	  parent 'parent zone'
	end

Above LWRP resource will create an icinga `Zone` object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *endpoints* (optional, String)	- icinga `Zone` attribute `endpoints`
- *parent* (optional, String)	- icinga `Zone` attribute `parent`
- *global* (optional, TrueClass/FalseClass)	- icinga `Zone` attribute `global`


## LWRP icinga2_endpoint

LWRP `endpoint` creates an icinga `Endpoint` object.


**LWRP Endpoint example**

	icinga2_endpoint 'endpoint' do
	  host 'host address'
	  port 1234
	  log_duration 'log duration'
	end

Above LWRP resource will create an icinga `Endpoint` object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *host* (optional, String)	- icinga `Endpoint` attribute `host`
- *port* (optional, Integer)	- icinga `Endpoint` attribute `port`
- *log_duration* (optional, String)	- icinga `Endpoint` attribute `log_duration`


## LWRP icinga2_timeperiod

LWRP `timeperiod` creates an icinga `TimePeriod` object.


**LWRP TimePeriod example**

	icinga2_timeperiod '24x7' do
	  import 'legacy-timeperiod'
	  display_name 'Icinga 2 24x7 TimePeriod'
	  ranges 'monday' => '00:00-24:00',
		'tuesday' => '00:00-24:00',
		'wednesday' => '00:00-24:00',
		'thursday' => '00:00-24:00',
		'friday' => '00:00-24:00',
		'saturday' => '00:00-24:00',
		'sunday' => '00:00-24:00'
	end

Above LWRP resource will create an icinga `TimePeriod` object.

**LWRP TimePeriod template**

	icinga2_timeperiod 'legacy-timeperiod' do
	  template true
	  display_name 'legacy-timeperiod'
	end

Above LWRP resource will create an icinga `TimePeriod` template.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *display_name* (optional, String)	- icinga `TimePeriod` attribute `display_name`
- *import* (optional, String)	- icinga `TimePeriod` attribute `import`
- *zone* (optional, String)	- icinga `TimePeriod` attribute `zone`
- *ranges* (optional, Hash)	- icinga `TimePeriod` attribute `ranges`
- *template* (optional, TrueClass/FalseClass)	- whether to create an icinga `TimePeriod` template


## LWRP icinga2_eventcommand

LWRP `eventcommand` creates an icinga `EventCommand` object.


**LWRP EventCommand example**

	icinga2_eventcommand 'eventcommand' do
	  command 'command name'
	  custom_vars :attribute => 'value'
	end

Above LWRP resource will create an icinga `EventCommand` object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *import* (optional, String)	- icinga `EventCommand` attribute `import`
- *command* (optional, String/Array)	- icinga `EventCommand` attribute `command`
- *env* (optional, Hash)	- icinga `EventCommand` attribute `env`
- *timeout* (optional, String/Integer)	- icinga `EventCommand` attribute `timeout`
- *arguments* (optional, Hash)	- icinga `EventCommand` attribute `arguments`
- *custom_vars* (optional, Hash)	- icinga `EventCommand` attribute `custom_vars`


## LWRP icinga2_checkcommand


LWRP `checkcommand` creates an icinga `CheckCommand` object.


**LWRP CheckCommand example**

	icinga2_checkcommand 'checkcommand' do
	  command 'command name'
	  env :attribute => 'value'
	  arguments :attribute => 'value'
	  custom_vars :attribute => 'value'
	  zone 'zone name'
	end

Above LWRP resource will create an icinga `CheckCommand` object.


**LWRP Options**

- *action* (optional, String)	- default :enable, options: :enable, :disable
- *import* (optional, String)	- default plugin-check-command, icinga `CheckCommand` attribute `import`
- *command* (optional, String/Array)	- icinga `CheckCommand` attribute `command`
- *env* (optional, Hash)	- icinga `CheckCommand` attribute `env`
- *timeout* (optional, Integer)	- icinga `CheckCommand` attribute `timeout`
- *zone* (optional, String)	- icinga `CheckCommand` attribute `zone`
- *arguments* (optional, Hash)	- icinga `CheckCommand` attribute `arguments`
- *custom_vars* (optional, Hash)	- icinga `CheckCommand` attribute `custom_vars`
- *template* (optional, TrueClass/FalseClass) - whether to create a `CheckCommand` template


## LWRP icinga2_scheduleddowntime


LWRP `scheduleddowntime` creates an icinga `ScheduledDowntime` object.


**LWRP ScheduledDowntime example**

	icinga2_scheduleddowntime 'downtime' do
	  host_name 'host name'
	  service_name 'service name'
	  author 'author'
	  comment 'comment'
	  duration 'duration'
	end

Above LWRP resource will create an icinga `ScheduledDowntime` object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *host_name* (optional, String)	- icinga `ScheduledDowntime` attribute `host_name`
- *service_name* (optional, String)	- icinga `ScheduledDowntime` attribute `service_name`
- *author* (optional, String)	- icinga `ScheduledDowntime` attribute `author`
- *comment* (optional, String)	- icinga `ScheduledDowntime` attribute `comment`
- *fixed* (optional, TrueClass/FalseClass)	- icinga `ScheduledDowntime` attribute `fixed`
- *duration* (optional, String)	- icinga `ScheduledDowntime` attribute `duration`
- *zone* (optional, String)	- icinga `ScheduledDowntime` attribute `zone`
- *ranges* (optional, Hash)	- icinga `ScheduledDowntime` attribute `ranges`
- *template* (optional, TrueClass/FalseClass)	- whether to create an icinga `ScheduledDowntime` template


## LWRP icinga2_script


LWRP `script` creates a template resource file script under `node['icinga2']['scripts_dir']`. This resource is optional and not necessary applicable to all scenarios.


**LWRP script example**

	icinga2_script 'mail-host-notification-custom.sh' do
	  cookbook 'wrapper_cookbook'
	  source 'mail-host-notification-custom.sh.erb'
	end

Above LWRP resource will create a script file under `node['icinga2']['scripts_dir']/mail-host-notification-custom.sh` using template `mail-host-notification-custom.sh.erb` from cookbook `wrapper_cookbook`.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *source* (optional, String)	- default :name, template resource attribute `source`
- *cookbook* (required, String)	- template resource attribute `cookbook`
- *variables* (optional, Hash)	- template resource attribute `variables`


## LWRP icinga2_externalcommandlistener

LWRP `externalcommandlistener` creates an icinga `ExternalCommandListener` object.


**LWRP ExternalCommandListener example**

	icinga2_externalcommandlistener 'externalcommandlistener' do
	  library 'library'
	  command_path 'command path'
	end

Above LWRP resource will create an icinga `ExternalCommandListener` config object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *library* (optional, String)	- default 'compat', icinga `ExternalCommandListener` attribute `library`
- *command_path* (optional, String)	- icinga `ExternalCommandListener` attribute `command_path`


## LWRP icinga2_gelfwriter

LWRP `gelfwriter` creates an icinga `GelfWriter` object.


**LWRP GelfWrite example**

	icinga2_gelfwriter 'gelfwriter' do
	  library 'library'
	  host 'host address'
	  port 1234
	  source 'source'
	end

Above LWRP resource will create an icinga `GelfWriter` config object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *library* (optional, String)	- default 'perfdata', icinga `GelfWriter` attribute `library`
- *host* (required, String)	- icinga `GelfWriter` attribute `host`
- *port* (required, Integer)	- icinga `GelfWriter` attribute `port`
- *source* (optional, String)	- icinga `GelfWriter` attribute `source`


## LWRP icinga2_graphitewriter

LWRP `graphitewriter` creates an icinga `GraphiteWriter` object.


**LWRP GraphiteWriter example**

	icinga2_graphitewriter 'graphitewriter' do
	  library 'library'
	  host 'host address'
	  port 1234
	end

Above LWRP resource will create an icinga `GraphiteWriter` config object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *library* (optional, String)	- default 'perfdata', icinga `GraphiteWriter` attribute `library`
- *host* (optional, String)	- icinga `GraphiteWriter` attribute `host`
- *port* (optional, Integer)	- icinga `GraphiteWriter` attribute `port`
- *host_name_template* (optional, String)	- default icinga.$host.name$, icinga `GraphiteWriter` attribute `host_name_template`
- *service_name_template* (optional, String)	- default icinga.$host.name$.$service.name$, icinga `GraphiteWriter` attribute `service_name_template`


## LWRP icinga2_idomysqlconnection

LWRP `idomysqlconnection` creates an icinga `IdoMySqlConnection` object.


**LWRP IdoMySqlConnection example**

	icinga2_idomysqlconnection 'idomysqlconnection' do
	  library 'library'
	  host 'host address'
	  port 1234
	  user 'user name'
	  password 'password'
	  database 'database name'
	end

Above LWRP resource will create an icinga `IdoMySqlConnection` config object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *library* (optional, String)	- default 'db_ido_mysql', icinga `IdoMySqlConnection` attribute `library`
- *host* (optional, String)	- icinga `IdoMySqlConnection` attribute `host`
- *port* (optional, Integer)	- icinga `IdoMySqlConnection` attribute `port`
- *user* (optional, String)	- icinga `IdoMySqlConnection` attribute `user`
- *password* (optional, String)	- icinga `IdoMySqlConnection` attribute `password`
- *database* (optional, String)	- icinga `IdoMySqlConnection` attribute `database`
- *table_prefix* (optional, String)	- default icinga_, icinga `IdoMySqlConnection` attribute `table_prefix`
- *instance_name* (optional, String)	- icinga `IdoMySqlConnection` attribute `instance_name`
- *instance_description* (optional, String)	- icinga `IdoMySqlConnection` attribute `instance_description`
- *enable_ha* (optional, TrueClass/FalseClass)	- icinga `IdoMySqlConnection` attribute `enable_ha`
- *failover_timeout* (optional, String/Integer)	- icinga `IdoMySqlConnection` attribute `failover_timeout`
- *cleanup* (optional, Hash)	- icinga `IdoMySqlConnection` attribute `cleanup`
- *categories* (optional, Array)	- icinga `IdoMySqlConnection` attribute `categories`


## LWRP icinga2_idopgsqlconnection

LWRP `idopgsqlconnection` creates an icinga `IdoPgSqlConnection` object.


**LWRP IdoPgSqlConnection example**

	icinga2_idopgsqlconnection 'idopgsqlconnection' do
	  library 'library'
	  host 'host address'
	  port 1234
	  user 'user name'
	  password 'password'
	  database 'database name'
	end

Above LWRP resource will create an icinga `IdoPgSqlConnection` config object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *library* (optional, String)	- default 'db_ido_mysql', icinga `IdoPgSqlConnection` attribute `library`
- *host* (optional, String)	- icinga `IdoPgSqlConnection` attribute `host`
- *port* (optional, Integer)	- icinga `IdoPgSqlConnection` attribute `port`
- *user* (optional, String)	- icinga `IdoPgSqlConnection` attribute `user`
- *password* (optional, String)	- icinga `IdoPgSqlConnection` attribute `password`
- *database* (optional, String)	- icinga `IdoPgSqlConnection` attribute `database`
- *table_prefix* (optional, String)	- icinga `IdoPgSqlConnection` attribute `table_prefix`
- *instance_name* (optional, String)	- icinga `IdoPgSqlConnection` attribute `instance_name`
- *instance_description* (optional, String)	- icinga `IdoPgSqlConnection` attribute `instance_description`
- *enable_ha* (optional, TrueClass/FalseClass)	- icinga `IdoPgSqlConnection` attribute `enable_ha`
- *failover_timeout* (optional, String/Integer)	- icinga `IdoPgSqlConnection` attribute `failover_timeout`
- *cleanup* (optional, Hash)	- icinga `IdoPgSqlConnection` attribute `cleanup`
- *categories* (optional, Array)	- icinga `IdoPgSqlConnection` attribute `categories`


## LWRP icinga2_sysloglogger

LWRP `sysloglogger` creates an icinga `SyslogLogger` object.


**LWRP SyslogLogger example**

	icinga2_sysloglogger 'sysloglogger' do
	  severity 'critical'
	end

Above LWRP resource will create an icinga `SyslogLogger` object.


**LWRP Options**

- *name*(name_attribute)	- icinga `SyslogLogger` name
- *severity* (optional, String)	- icinga `SyslogLogger` attribute `port`


## LWRP icinga2_notification


LWRP `notification` creates an icinga `Notification` object.


**LWRP Notification Object example**

	icinga2_notification 'notification' do
	  import 'notification template'
	  host_name 'host'
	  service_name 'service'
	  users %w(user)
	  user_groups %w(usergroup)
	  interval 'interval'
	  period 'period'
	  states %w(OK Warning Critical Unknown Up Down)
	  types %w(Custom Acknowledgement Problem Recovery)
	end


Above LWRP resource will create an icinga `Notification` object.

**LWRP Notification Template example**

	icinga2_notification 'notification' do
	  template true
	  period '24x7'
	end

Above LWRP resource will create an icinga `Notification` template.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *import* (optional, String)	- icinga `Notification` attribute `import`
- *host_name* (optional, String)	- icinga `Notification` attribute `host_name`
- *service_name* (optional, String)	- icinga `Notification` attribute `service_name`
- *users* (optional, Array)	- icinga `Notification` attribute `users`
- *user_groups* (optional, Array)	- icinga `Notification` attribute `user_groups`
- *times* (optional, Hash)	- icinga `Notification` attribute `times`
- *command* (optional, String)	- icinga `Notification` attribute `command`
- *interval* (optional, String/Integer)	- icinga `Notification` attribute `interval`
- *period* (optional, String)	- icinga `Notification` attribute `period`
- *zone* (optional, String)	- icinga `Notification` attribute `zone`
- *types* (optional, Array)	- icinga `Notification` attribute `types`
- *states* (optional, Array)	- icinga `Notification` attribute `states`
- *custom_vars* (optional, Hash)	- icinga `Notification` attribute `vars`
- *template* (optional, TrueClass/FalseClass)	- whether to create a `Notification` template


## LWRP icinga2_applynotification

LWRP `applynotification` creates an icinga `apply Notification` object for `Host` and `Service`.


**LWRP apply Notification Service Object example**

	icinga2_applynotification 'servicenotification' do
	  object_type 'Service'
	  command 'mail-service-notification'
	  users %w(user)
	  interval '1h'
	  assign_where ['host.address && host.vars.environment == "development"']
	  ignore_where ['host.vars.monitoring_disabled == true']
	end



Above LWRP resource will apply `Notification` to all `Service` objects for provided `assign where` statements and ignore for specified `ignore where` statements.

**LWRP apply Notification Host Object example**

	icinga2_applynotification 'hostnotification' do
	  object_type 'Host'
	  command 'mail-host-notification'
	  users %w(user)
	  interval '1h'
	  assign_where ['host.address && host.vars.environment == "development"']
	  ignore_where ['host.vars.monitoring_disabled == true']
	end


Above LWRP resource will apply `Notification` to all `Host` objects for provided `assign_where` statements and ignore for specified `ignore_where` statements.


**LWRP Options**

- *object_type* (required, String)	- apply Notification to `Host` or `Service`, valid values are: Host Service
- *action* (optional, String)	- default :enable, options: :enable, :disable
- *import* (optional, String)	- icinga `Notification` attribute `import`
- *users* (optional, Array)	- icinga `Notification` attribute `users`
- *user_groups* (optional, Array)	- icinga `Notification` attribute `user_groups`
- *times* (optional, Hash)	- icinga `Notification` attribute `times`
- *command* (optional, String)	- icinga `Notification` attribute `command`
- *interval* (optional, String/Integer)	- icinga `Notification` attribute `interval`
- *period* (optional, String)	- icinga `Notification` attribute `period`
- *types* (optional, Array)	- icinga `Notification` attribute `types`
- *states* (optional, Array)	- icinga `Notification` attribute `states`
- *assign_where* (optional, Array)	- icinga `assign where` statements
- *ignore_where* (optional, Array)	- icinga `ignore where` statements


## LWRP icinga2_notificationcommand

LWRP `notificationcommand` creates an icinga `NotificationCommand` object.


**LWRP NotificationCommand example**

	icinga2_notificationcommand 'mail-service-notification' do
	  command ['SysconfDir + "/icinga2/scripts/mail-service-notification.sh"']
	  env 'NOTIFICATIONTYPE' => '$notification.type$', \
        'SERVICEDESC' => '$service.name$',\
        'HOSTALIAS' => '$host.display_name$',\
        'HOSTADDRESS' => '$address$',\
        'SERVICESTATE' => '$service.state$',\
        'LONGDATETIME' => '$icinga.long_date_time$',\
        'SERVICEOUTPUT' => '$service.output$',\
        'NOTIFICATIONAUTHORNAME' => '$notification.author$',\
        'NOTIFICATIONCOMMENT' => '$notification.comment$',\
        'HOSTDISPLAYNAME' => '$host.display_name$',\
        'SERVICEDISPLAYNAME' => '$service.display_name$',\
        'USEREMAIL' => '$user.email$'
	end

Above LWRP resource will create an icinga `NotificationCommand` object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *import* (optional, String)	- default plugin-notification-command, icinga `NotificationCommand` attribute `cert_path`
- *command* (optional, String/Array)	- icinga `NotificationCommand` attribute `command`
- *env* (optional, Hash)	- icinga `NotificationCommand` attribute `env`
- *timeout* (optional, Integer)	- icinga `NotificationCommand` attribute `timeout`
- *zone* (optional, String)	- icinga `NotificationCommand` attribute `zone`
- *arguments* (optional, Hash)	- icinga `NotificationCommand` attribute `arguments`
- *custom_vars* (optional, Hash)	- icinga `NotificationCommand` attribute `vars`



## LWRP icinga2_apilistener

LWRP `apilistener` creates an icinga `ApiListener` object.


**LWRP ApiListener example**

	icinga2_apilistener 'master' do
	  cert_path 'SysconfDir + "/icinga2/pki/" + NodeName + ".crt"'
	  key_path 'SysconfDir + "/icinga2/pki/" + NodeName + ".key"'
	  ca_path 'SysconfDir + "/icinga2/pki/ca.crt"'
	  bind_host 'host address'
	  bind_port '5665'
	  ticket_salt 'TicketSalt'
	end

Above LWRP resource will create an icinga `ApiListener` object.


**LWRP Options**

- *action* (optional, String)	- default :enable, options: :enable, :disable
- *cert_path* (required, String)	- icinga `ApiListener` attribute `cert_path`
- *key_path* (required, String)	- icinga `ApiListener` attribute `key_path`
- *ca_path* (required, String)	- icinga `ApiListener` attribute `ca_path`
- *crl_path* (optional, String)	- icinga `ApiListener` attribute `crl_path`
- *bind_host* (optional, String)	- icinga `ApiListener` attribute `bind_host`
- *bind_port* (optional, String)	- icinga `ApiListener` attribute `bind_port`
- *ticket_salt* (optional, String)	- icinga `ApiListener` attribute `ticket_salt`
- *accept_config* (optional, TrueClass/FalseClass)	- icinga `ApiListener` attribute `accept_config`
- *accept_commands* (optional, TrueClass/FalseClass)	- icinga `ApiListener` attribute `accept_commands`


## LWRP icinga2_livestatuslistener

LWRP `livestatuslistener` creates an icinga `LiveStatusListener` object.


**LWRP LiveStatusListener example**

	icinga2_livestatuslistener 'livestatuslistener' do
	  socket_type 'socket type'
	  socket_path 'socket path'
	  bind_host 'host address'
	  bind_port 'host port'
	  compat_log_path 'log path'
	end

Above LWRP resource will create an icinga `LiveStatusListener` object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *socket_type* (optional, String)	- icinga `LiveStatusListener` attribute `socket_type`
- *socket_path* (optional, String)	- icinga `LiveStatusListener` attribute `socket_path`
- *bind_host* (optional, String)	- icinga `LiveStatusListener` attribute `bind_host`
- *bind_port* (optional, Integer)	- icinga `LiveStatusListener` attribute `bind_port`
- *compat_log_path* (optional, String)	- icinga `LiveStatusListener` attribute `compat_log_path`



## LWRP icinga2_statusdatawriter

LWRP `statusdatawriter` creates an icinga `StatusDataWriter` object.


**LWRP StatusDataWriter example**

	icinga2_statusdatawriter 'statusdatawriter' do
	  status_path 'status path'
	  objects_path 'objects path'
	  update_interval 'update interval'
	end

Above LWRP resource will create an icinga `StatusDataWriter` object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *library* (optional, String)	- default compat, icinga `StatusDataWriter` Object `library`
- *status_path* (optional, String)	- icinga `StatusDataWriter` attribute `status_path`
- *objects_path* (optional, String)	- icinga `StatusDataWriter` attribute `objects_path`
- *update_interval* (optional, String/Integer)	- icinga `StatusDataWriter` attribute `update_interval`



## LWRP icinga2_compatlogger

LWRP `compatlogger` creates an icinga `CompatLogger` object.


**LWRP CompatLogger example**

	icinga2_compatlogger 'compatlogger' do
	  log_dir 'log dir'
	  rotation_method 'rotation method'
	end

Above LWRP resource will create an icinga `CompatLogger` object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *library* (optional, String)	- default compat, icinga `CompatLogger` Object `library`
- *log_dir* (optional, String)	- icinga `CompatLogger` attribute `log_dir`
- *rotation_method* (optional, String)	- icinga `CompatLogger` attribute `rotation_method`



## LWRP icinga2_checkresultreader

LWRP `checkresultreader` creates an icinga `CheckResultReader` object.


**LWRP CheckResultReader example**

	icinga2_checkresultreader 'checkresultreader' do
	  spool_dir 'spool dir'
	end

Above LWRP resource will create an icinga `CheckResultReader` object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *library* (optional, String)	- default compat, icinga `CheckResultReader` Object `library`
- *spool_dir* (optional, String)	- icinga `CheckResultReader` attribute `spool_dir`



## LWRP icinga2_notificationcomponent

LWRP `notificationcomponent` creates an icinga `NotificationComponent` object.


**LWRP NotificationComponent example**

	icinga2_notificationcomponent 'notificationcomponent' do
	end


Above LWRP resource will create an icinga `NotificationComponent` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *library* (optional, String)	- default notification, icinga `NotificationComponent` Object `library`
- *enable_ha* (optional, String)	- icinga `NotificationComponent` attribute `enable_ha`


## LWRP icinga2_filelogger

LWRP `filelogger` creates an icinga `FileLogger` object.


**LWRP FileLogger example**

	icinga2_filelogger 'filelogger' do
	end


Above LWRP resource will create an icinga `FileLogger` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *path* (optional, String)	- icinga `FileLogger` attribute `path`
- *severity* (optional, String)	- icinga `FileLogger` attribute `severity`


## LWRP icinga2_perfdatawriter

LWRP `perfdatawriter` creates an icinga `PerfdataWriter` object.


**LWRP PerfdataWriter example**

	icinga2_perfdatawriter 'perfdatawriter' do
	  host_perfdata_path 'host perfdata path'
	  service_perfdata_path 'service perfdata path'
	  host_format_template 'host perfdata format'
	  service_format_template 'service perfdata format'
	  rotation_interval 'rotation interval'
	end

Above LWRP resource will create an icinga `PerfdataWriter` object.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *library* (optional, String)	- default perfdata, icinga `PerfdataWriter` Object `library`
- *host_perfdata_path* (optional, String)	- icinga `PerfdataWriter` attribute  `host_perfdata_path`
- *service_perfdata_path* (optional, String)	- icinga `PerfdataWriter` attribute  `service_perfdata_path`
- *host_temp_path* (optional, String)	- icinga `PerfdataWriter` attribute `host_temp_path`
- *service_temp_path* (optional, String)	- icinga `PerfdataWriter` attribute `service_temp_path`
- *host_format_template* (optional, String)	- icinga `PerfdataWriter` attribute `host_format_template`
- *service_format_template* (optional, String)	- icinga `PerfdataWriter` attribute `service_format_template`
- *rotation_interval* (optional, String/Integer)	- icinga `PerfdataWriter` attribute `rotation_interval`



## LWRP icinga2_applydependency

LWRP `applydependency` creates an icinga `apply Dependency` object for `Host` and `Service`.


**LWRP apply Dependency Service Object example**

	icinga2_applydependency 'applyservicedependency' do
	  object_type 'Service'
	  parent_service_name 'check_nrpe'
	  states %w(OK Critical Unknown Warning)
	  period '24x7'
	  assign_where ['service.check_command == "nrpe"']
	  ignore_where ['service.name == "check_nrpe"']
	end


Above LWRP resource will apply `Dependency` to all `Service` objects for provided `assign where` statements and ignore for specified `ignore where` statements.

**LWRP apply Dependency Host Object example**

	icinga2_applydependency 'applyhostdependency' do
	  object_type 'Host'
	  parent_host_name 'gateway host'
	  states %w(Down Unknown)
	  period '24x7'
	  assign_where %w(host.address)
	  ignore_where ['!host.address']
	end


Above LWRP resource will apply `Dependency` to all `Host` objects for provided `assign_where` statements and ignore for specified `ignore_where` statements.


**LWRP Options**

- *action* (optional)	- default :enable, options: :enable, :disable
- *object_relation* (optional, String) - default `to`, apply `Dependency` relation
- *object_type* (required, String)	- apply Notification to `Host` or `Service`, valid values are: Host Service
- *parent_host_name* (optional, String)	- icinga apply `Dependency` attribute `parent_host_name`
- *child_host_name* (optional, String)	- icinga apply `Dependency` attribute `child_host_name`
- *parent_service_name* (optional, String)	- icinga apply `Dependency` attribute `parent_service_name`
- *child_service_name* (optional, String)	- icinga apply `Dependency` attribute `child_service_name`
- *disable_checks* (optional, TrueClass/FalseClass)	- icinga apply `Dependency` attribute `disable_checks`
- *disable_notifications* (optional, TrueClass/FalseClass)	- icinga apply `Dependency` attribute `disable_notifications`
- *period* (optional, String)	- icinga apply `Dependency` attribute `period`
- *states* (optional, Array)	- icinga apply `Dependency` attribute `states`
- *assign_where* (optional, Array)	- icinga `assign where` statements
- *ignore_where* (optional, Array)	- icinga `ignore where` statements


## Cookbook Advanced Attributes

* `default['icinga2']['disable_conf_d']` (default: `true`): disable icinga2 `conf.d` default configuration directory in `icinga2.conf` and use LWRP to manage icinga2 objects / templates

* `default['icinga2']['build_type']` (default: `release`): icinga2 repository build type, options: release snapshot

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

* `default['icinga2']['web_engine']` (default: `'apache'): icinga2 web server, currently supports only apache

* `default['icinga2']['install_nagios_plugins']` (default: `true`): install nagios plugins to icinga2 server and clients

* `default['icinga2']['enable_env_pki']` (default: `false`): whether to create env endpoints, zones and pki_tickets



## Cookbook Core Attributes

* `default['icinga2']['version']` (default: `2.6.1-X, calculated`): icinga2 version

* `default['icinga2']['conf_dir']` (default: `/etc/icinga2`): icinga2 configuration location

* `default['icinga2']['conf_d_dir']` (default: `/etc/icinga2/conf.d`): icinga2 conf.d directory location

* `default['icinga2']['pki_dir']` (default: `/etc/icinga2/pki`): icinga2 pki directory location

* `default['icinga2']['scripts_dir']` (default: `/etc/icinga2/scripts`): icinga2 script directory location

* `default['icinga2']['zones_dir']` (default: `/etc/icinga2/zones.d`): icinga2 zones.d directory location

* `default['icinga2']['databag']` (default: `'icinga2'): icinga2 databag name, currently not used

* `default['icinga2']['objects_d']` (default: `'objects.d`): cookbook created icinga2 Object/Templates resources directory name

* `default['icinga2']['objects_dir']` (default: `/etc/icinga2/objects.d`): cookbook created icinga2 Object/Templates resources directory location

* `default['icinga2']['run_dir']` (default: `/var/run/icinga2`): icinga2 run directory

* `default['icinga2']['run_cmd_dir']` (default: `/var/run/icinga2/cmd`): icinga2 location for process `icinga2.cmd`

* `default['icinga2']['cache_dir']` (default: `/var/cache/icinga2`): icinga2 cache directory location

* `default['icinga2']['spool_dir']` (default: `/var/spool/icinga2`): icinga2 spool directory location

* `default['icinga2']['lib_dir']` (default: `/var/lib/icinga2`): icinga2 lib directory location

* `default['icinga2']['log_dir']` (default: `/var/log/icinga2`): icinga2 core process log directory location

* `default['icinga2']['cache_dir']` (default: `/var/cache/icinga2`): icinga2 cache directory location

* `default['icinga2']['perfdata_dir']` (default: `/var/spool/icinga2/perfdata`): icinga2 perfdata directory location

* `default['icinga2']['service_name']` (default: `icinga2'`): icinga2 process name*

* `default['icinga2']['service_config_file']` (default: `/etc/default/icinga2`): icinga2 * process configuration file

* `default['icinga2']['plugins_dir']` (default: `/usr/lib/nagios/plugins`): icinga2 plugins directory location

* `default['icinga2']['custom_plugins_dir']` (default: `/opt/icinga2_custom_plugins`): icinga2 custom plugins directory

* `default['icinga2']['admin_user']` (default: `icingaadmin`): icinga2 admin user

* `default['icinga2']['user']` (default: `icinga`): icinga2 user

* `default['icinga2']['group']` (default: `icinga`): icinga2 user group

* `default['icinga2']['cmdgroup']` (default: `icingacmd`): icinga2 cmd user group

* `default['icinga2']['user_defined_objects_dir']` (default: `['user_defined_objects']`): user defined configuration directories, each directory is included in `icinga2.conf` file.

* `default['icinga2']['cmdgroup']` (default: `icingacmd`): icinga2 cmd user group

* `default['icinga2']['apache_modules']` (default: `calculated`): apache modules / apache2 cookbook recipe to enable


## Cookbook Icinga2 Constants Attributes

* `default['icinga2']['server']['constants']['NodeName']` (default: `node['fqdn']`): icinga2 NodeName constant

* `default['icinga2']['server']['constants']['PluginDir']` (default: `node['icinga2']['plugins_dir']`): icinga2 plugins directory location

* `default['icinga2']['server']['constants']['ManubulonPluginDir']` (default: `node['icinga2']['plugins_dir']`): icinga2 plugins directory location

* `default['icinga2']['server']['constants']['TicketSalt']` (default: `ed25aed394c4bf7d236b347bb67df466`): icinga2 default TicketSalt key


## Cookbook Icinga2 Host Object default Attributes

* `default['icinga2']['server']['object']['global-templates']` (default: `false`)

* `default['icinga2']['server']['object']['host']['import']` (default: `'generic-host`)

* `default['icinga2']['server']['object']['host']['max_check_attempts']` (default: `3`)

* `default['icinga2']['server']['object']['host']['check_period']` (default: `nil`)

* `default['icinga2']['server']['object']['host']['notification_period']` (default: `nil`)

* `default['icinga2']['server']['object']['host']['check_interval']` (default: `1800`)

* `default['icinga2']['server']['object']['host']['retry_interval']` (default: `60`)

* `default['icinga2']['server']['object']['host']['enable_notifications']` (default: `true`)

* `default['icinga2']['server']['object']['host']['enable_active_checks']` (default: `true`)

* `default['icinga2']['server']['object']['host']['enable_passive_checks']` (default: `false`)

* `default['icinga2']['server']['object']['host']['enable_event_handler']` (default: `true`)

* `default['icinga2']['server']['object']['host']['enable_flapping']` (default: `true`)

* `default['icinga2']['server']['object']['host']['enable_perfdata']` (default: `true`)

* `default['icinga2']['server']['object']['host']['event_command']` (default: `nil`)

* `default['icinga2']['server']['object']['host']['flapping_threshold']` (default: `nil`)

* `default['icinga2']['server']['object']['host']['volatile']` (default: `nil`)

* `default['icinga2']['server']['object']['host']['check_command']` (default: `hostalive`)

* `default['icinga2']['server']['object']['host']['zone']` (default: `nil`)

* `default['icinga2']['server']['object']['host']['command_endpoint']` (default: `nil`)


## Cookbook Icinga2 IDO Attributes

 * `default['icinga2']['ido']['type']` (default: `mysql`): icinga2 ido type, valid are `mysql pgsql`

 * `default['icinga2']['ido']['load_schema']` (default: `false`): whether to load db schema

 * `default['icinga2']['ido']['install_mysql_client']` (default: `false`): install mysql client using mysql official repository

 * `default['icinga2']['ido']['db_host']` (default: `localhost`): Icinga2 ido db host

 * `default['icinga2']['ido']['db_port']` (default: `3306`): Icinga2 ido db port

 * `default['icinga2']['ido']['db_name']` (default: `icinga`): Icinga2 ido db name

 * `default['icinga2']['ido']['db_user']` (default: `icinga`): Icinga2 ido db user

 * `default['icinga2']['ido']['db_password']` (default: `icinga`): Icinga2 ido db password

 * `default['icinga2']['ido']['mysql_home']` (default: `/etc/mysql`): sets value for environment variable `MYSQL_HOME` for schema load

 * `default['icinga2']['ido']['mysql_version']` (default: `false`): install mysql client if set true

 * `default['icinga2']['ido']['yum']['description']` (default: `MySQL Community #{node['icinga2']['ido']['mysql_version']}`): yum repo resource attribute

 * `default['icinga2']['ido']['yum']['gpgcheck']` (default: `true`): yum repo resource attribute

 * `default['icinga2']['ido']['yum']['enabled']` (default: `true`): yum repo resource attribute

 * `default['icinga2']['ido']['yum']['gpgkey']` (default: `https://raw.githubusercontent.com/Icinga/chef-icinga2/master/files/default/mysql_pubkey.asc`): yum repo resource attribute

 * `default['icinga2']['ido']['yum']['action']` (default: `:create`): yum repo resource attribute

 * `default['icinga2']['ido']['yum']['baseurl']` (default: `calculated`): yum repo resource attribute

 * `default['icinga2']['ido']['apt']['repo']` (default: `MySQL Community #{node['icinga2']['ido']['mysql_version']}`): apt repository resource attribute

 * `default['icinga2']['ido']['apt']['keyserver']` (default: `keyserver.ubuntu.com`): apt repository resource attribute

 * `default['icinga2']['ido']['apt']['components']` (default: `["mysql-#{node['icinga2']['ido']['mysql_version']}"]`): apt repository resource attribute

 * `default['icinga2']['ido']['apt']['deb_src']` (default: `false`): apt repository resource attribute

 * `default['icinga2']['ido']['apt']['action']` (default: `:add`): apt repository resource attribute

 * `default['icinga2']['ido']['apt']['repo']` (default: `MySQL Community #{node['icinga2']['ido']['mysql_version']}`): apt repository resource attribute

 * `default['icinga2']['ido']['apt']['uri']` (default: `http://repo.mysql.com/apt/#{node['platform']}/`): apt repository resource attribute

 * `default['icinga2']['ido']['apt']['distribution']` (default: `node['lsb']['codename']`): apt repository resource attribute

 * `default['icinga2']['ido']['apt']['key']` (default: `5072E1F5`): apt repository resource attribute


## Cookbook Icingaweb2 Attributes

 * `default['icinga2']['web2']['enable']` (default: `false`): whether to setup icingaweb2

 * `default['icinga2']['web2']['install_method']` (default: `package`): icingaweb2 install method, options: package, source

 * `default['icinga2']['web2']['source_url']` (default: `git://git.icinga.org/icingaweb2.git`):

 * `default['icinga2']['web2']['version']['icingaweb2']` (default: `2.4.1-1`): icingaweb2 version

 * `default['icinga2']['web2']['version']['icingacli']` (default: `2.4.1-1`): icingacli version

 * `default['icinga2']['web2']['web_root']` (default: `/usr/share/icingaweb2`): icingaweb2 web root location

 * `default['icinga2']['web2']['web_uri']` (default: `/icingaweb2`): icingweb2 web uri

 * `default['icinga2']['web2']['conf_dir']` (default: `/etc/icingaweb2`): icingaweb2 config directory

 * `default['icinga2']['web2']['log_dir']` (default: `/var/log/icingaweb2`): icingaweb2 log directory


## Cookbook Ulimit Attributes

 * `default['icinga2']['limits']['memlock']` (default: `unlimited`): Icinga2 service user memory limit

 * `default['icinga2']['limits']['nofile']` (default: `48000`): Icinga2 service user file limit

 * `default['icinga2']['limits']['nproc']` (default: `unlimited`): Icinga2 service user process limit


## Cookbook Repository Attributes

* `default['icinga2']['yum']['description']` (default: `ICINGA Release'):

* `default['icinga2']['yum']['mirrorlist']` (default: `nil`):

* `default['icinga2']['yum']['gpgcheck']` (default: `true`):

* `default['icinga2']['yum']['enabled']` (default: `true`):

* `default['icinga2']['yum']['gpgkey']` (default: `http://packages.icinga.org/icinga.key`):

* `default['icinga2']['yum']['action']` (default: `:create`):

* `default['icinga2']['yum']['baseurl']` (default: `calculated`):

* `default['icinga2']['apt']['repo']` (default: `ICINGA Release`):

* `default['icinga2']['apt']['uri']` (default: `calculated`):

* `default['icinga2']['apt']['distribution']` (default: `node['lsb']['codename']`):

* `default['icinga2']['apt']['keyserver']` (default: `keyserver.ubuntu.com`):

* `default['icinga2']['apt']['components']` (default: `[main]`):

* `default['icinga2']['apt']['deb_src']` (default: `true`):

* `default['icinga2']['apt']['repo_key']` (default: `http://packages.icinga.org/icinga.key`):

* `default['icinga2']['apt']['action']` (default: `:add`):


## Cookbook Classic UI CGI Core Attributes

* `default['icinga2']['classic_ui']['enable']` (default: `false`): setup icinga2 classic-ui if set true

* `default['icinga2']['classic_ui']['version']` (default: `2.6.1-1`): icinga2 classic-ui package version

* `default['icinga2']['classic_ui']['gui_version']` (default: `1.14.0-0`): icinga2 gui package version

* `default['icinga2']['classic_ui']['web_root']` (default: `/usr/share/icinga`): icinga2 web doc root directory location

* `default['icinga2']['classic_ui']['home_dir']` (default: `/etc/icinga`): icinga2 classic ui configuration home directory location

* `default['icinga2']['classic_ui']['conf_dir']` (default: `/etc/icinga`): icinga2 classic ui configuration directory location

* `default['icinga2']['classic_ui']['log_dir']` (default: `/var/log/icinga`): icinga2 classic ui log directory location

* `default['icinga2']['classic_ui']['cgi_log_dir']` (default: `/var/log/icinga/gui`): icinga2 gui log directory location


## Cookbook Classic UI CGI User Access Attributes

* `default['icinga2']['classic_ui']['users']` (default: `{ 'icingaadmin' => 'icingaadmin' }`): Hash List of user => password (md5) for class ui access

* `default['icinga2']['classic_ui']['authorized_for_system_information']` (default: `[node['icinga2']['admin_user']]`): Array list of users authorized for system information

* `default['icinga2']['classic_ui']['authorized_for_configuration_information']` (default: `[node['icinga2']['admin_user']]`): Array list of users authorized for configuration information

* `default['icinga2']['classic_ui']['authorized_for_full_command_resolution']` (default: `[node['icinga2']['admin_user']]`): Array list of users authorized for full command resolution

* `default['icinga2']['classic_ui']['authorized_for_system_commands']` (default: `[node['icinga2']['admin_user']]`): Array list of users authorized for system commands

* `default['icinga2']['classic_ui']['authorized_for_all_services']` (default: `[node['icinga2']['admin_user']]`): Array list of users authorized for all services

* `default['icinga2']['classic_ui']['authorized_for_all_hosts']` (default: `[node['icinga2']['admin_user']]`): Array list of users authorized for all hosts

* `default['icinga2']['classic_ui']['authorized_for_all_service_commands']` (default: `[node['icinga2']['admin_user']]`): Array list of users authorized for all service commands

* `default['icinga2']['classic_ui']['authorized_for_all_host_commands']` (default: `[node['icinga2']['admin_user']]`): Array list of users authorized for all host commands


## Cookbook Classic UI CGI Configuration Attributes

* `default['icinga2']['classic_ui']['cgi']['standalone_installation']` (default: `1`)

* `default['icinga2']['classic_ui']['cgi']['physical_html_path']` (default: `/usr/share/icinga`)

* `default['icinga2']['classic_ui']['cgi']['url_html_path']` (default: `/icinga`)

* `default['icinga2']['classic_ui']['cgi']['url_stylesheets_path']` (default: `/icinga/stylesheets`)

* `default['icinga2']['classic_ui']['cgi']['http_charset']` (default: `utf-8`)

* `default['icinga2']['classic_ui']['cgi']['refresh_rate']` (default: `60`)

* `default['icinga2']['classic_ui']['cgi']['refresh_type']` (default: `1`)

* `default['icinga2']['classic_ui']['cgi']['escape_html_tags']` (default: `1`)

* `default['icinga2']['classic_ui']['cgi']['result_limit']` (default: `50`)

* `default['icinga2']['classic_ui']['cgi']['show_tac_header']` (default: `1`)

* `default['icinga2']['classic_ui']['cgi']['use_pending_states']` (default: `1`)

* `default['icinga2']['classic_ui']['cgi']['first_day_of_week']` (default: `0`)

* `default['icinga2']['classic_ui']['cgi']['suppress_maintenance_downtime']` (default: `0`)

* `default['icinga2']['classic_ui']['cgi']['action_url_target']` (default: `main`)

* `default['icinga2']['classic_ui']['cgi']['notes_url_target']` (default: `main`)

* `default['icinga2']['classic_ui']['cgi']['use_authentication']` (default: `1`)

* `default['icinga2']['classic_ui']['cgi']['use_ssl_authentication']` (default: `0`)

* `default['icinga2']['classic_ui']['cgi']['lowercase_user_name']` (default: `0`)

* `default['icinga2']['classic_ui']['cgi']['authorized_for_system_information']` (default: `node['icinga2']['classic_ui']['authorized_for_system_information'].join(',')`)

* `default['icinga2']['classic_ui']['cgi']['authorized_for_configuration_information']` (default: `node['icinga2']['classic_ui']* ['authorized_for_configuration_information'].join(',')`)

* `default['icinga2']['classic_ui']['cgi']['authorized_for_full_command_resolution']` (default: `node['icinga2']['classic_ui']['authorized_for_full_command_resolution'].join(',')`)

* `default['icinga2']['classic_ui']['cgi']['authorized_for_system_commands']` (default: `node['icinga2']['classic_ui']['authorized_for_system_commands'].join(',')`)

* `default['icinga2']['classic_ui']['cgi']['authorized_for_all_services']` (default: `node['icinga2']['classic_ui']['authorized_for_all_services'].join(',')`)

* `default['icinga2']['classic_ui']['cgi']['authorized_for_all_hosts']` (default: `node['icinga2']['classic_ui']['authorized_for_all_hosts'].join(',')`)

* `default['icinga2']['classic_ui']['cgi']['authorized_for_all_service_commands']` (default: `node['icinga2']['classic_ui']['authorized_for_all_service_commands'].join(',')`)

* `default['icinga2']['classic_ui']['cgi']['authorized_for_all_host_commands']` (default: `node['icinga2']['classic_ui']['authorized_for_all_host_commands'].join(',')`)

* `default['icinga2']['classic_ui']['cgi']['show_all_services_host_is_authorized_for']` (default: `1`)

* `default['icinga2']['classic_ui']['cgi']['show_partial_hostgroups']` (default: `0`)

* `default['icinga2']['classic_ui']['cgi']['show_partial_servicegroups']` (default: `0`)

* `default['icinga2']['classic_ui']['cgi']['default_statusmap_layout']` (default: `5`)

* `default['icinga2']['classic_ui']['cgi']['status_show_long_plugin_output']` (default: `0`)

* `default['icinga2']['classic_ui']['cgi']['display_status_totals']` (default: `0`)

* `default['icinga2']['classic_ui']['cgi']['highlight_table_rows']` (default: `1`)

* `default['icinga2']['classic_ui']['cgi']['add_notif_num_hard']` (default: `28`)

* `default['icinga2']['classic_ui']['cgi']['add_notif_num_soft']` (default: `0`)

* `default['icinga2']['classic_ui']['cgi']['use_logging']` (default: `0`)

* `default['icinga2']['classic_ui']['cgi']['cgi_log_file']` (default: `node['icinga2']['classic_ui']['cgi_log_dir']/icinga-cgi.log`)

* `default['icinga2']['classic_ui']['cgi']['cgi_log_rotation_method']` (default: `d`)

* `default['icinga2']['classic_ui']['cgi']['cgi_log_archive_path']` (default: `node['icinga2']['classic_ui']['cgi_log_dir']`)

* `default['icinga2']['classic_ui']['cgi']['enforce_comments_on_actions']` (default: `0`)

* `default['icinga2']['classic_ui']['cgi']['send_ack_notifications']` (default: `1`)

* `default['icinga2']['classic_ui']['cgi']['persistent_ack_comments']` (default: `0`)

* `default['icinga2']['classic_ui']['cgi']['lock_author_names']` (default: `1`)

* `default['icinga2']['classic_ui']['cgi']['default_downtime_duration']` (default: `7200`)

* `default['icinga2']['classic_ui']['cgi']['set_expire_ack_by_default']` (default: `0`)

* `default['icinga2']['classic_ui']['cgi']['default_expiring_acknowledgement_duration']` (default: `86_400`)

* `default['icinga2']['classic_ui']['cgi']['default_expiring_disabled_notifications_duration']` (default: `86_400`)

* `default['icinga2']['classic_ui']['cgi']['tac_show_only_hard_state']` (default: `0`)

* `default['icinga2']['classic_ui']['cgi']['show_tac_header_pending']` (default: `1`)

* `default['icinga2']['classic_ui']['cgi']['exclude_customvar_name']` (default: `PASSWORD,COMMUNITY`)

* `default['icinga2']['classic_ui']['cgi']['exclude_customvar_value']` (default: `secret`)

* `default['icinga2']['classic_ui']['cgi']['extinfo_show_child_hosts']` (default: `)

* `default['icinga2']['classic_ui']['cgi']['tab_friendly_titles']` (default: `1`)

* `default['icinga2']['classic_ui']['cgi']['object_cache_file']` (default: `/var/cache/icinga2/objects.cache`)

* `default['icinga2']['classic_ui']['cgi']['status_file']` (default: `node['icinga2']['cache_dir']/status.dat`)

* `default['icinga2']['classic_ui']['cgi']['resource_file']` (default: `node['icinga2']['classic_ui']['conf_dir']/resource.cfg`)

* `default['icinga2']['classic_ui']['cgi']['command_file']` (default: `node['icinga2']['run_dir']/cmd/icinga2.cmd`)

* `default['icinga2']['classic_ui']['cgi']['check_external_commands']` (default: `1`)

* `default['icinga2']['classic_ui']['cgi']['interval_length']` (default: `60`)

* `default['icinga2']['classic_ui']['cgi']['status_update_interval']` (default: `10`)

* `default['icinga2']['classic_ui']['cgi']['log_file']` (default: `node['icinga2']['log_dir']/compat/icinga.log`)

* `default['icinga2']['classic_ui']['cgi']['log_rotation_method']` (default: `h`)

* `default['icinga2']['classic_ui']['cgi']['log_archive_path']` (default: `node['icinga2']['log_dir']/compat/archives`)

* `default['icinga2']['classic_ui']['cgi']['date_format']` (default: `us`)


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


[Icinga2]: https://www.icinga.org/
[Chef]: https://www.chef.io/
[Install]: https://github.com/icinga/icinga2/
[Dev Icinga]: https://dev.icinga.org/projects/chef-icinga2
[Register]: https://www.icinga.org/register/
