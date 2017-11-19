icinga2 Cookbook LWRP
==================

## LWRP Examples

Different LWRP usage examples are added to `examples` directory.

To configure icinga2 server, check `examples/icinga2_server` directory. More examples will be added as we go.


## LWRP 'assign where' and 'ignore where' statements

**assign where (icinga) = assign_where (LWRP)**

**ignore where (icinga) = ignore_where (LWRP)**

`assign where` statements are defined as a LWRP resource `Array` attribute -`assign_where`. Each array element is treated as a different `assign where` statement and LWRP creates a separate statement.

e.g.
```ruby
assign_where ['host.address',
  'host.vars.nrpe && host.vars.enable_check',
  'host.vars.application == "redis"'
]
```

Above LWRP resource will be applied to an `Object` as shown below:

```ruby
assign where host.address
assign where host.vars.nrpe && host.vars.enable_check
assign where host.vars.application == "redis"
```

Similarly, `ignore where` statements are created using LWRP resource `Array` attribute `ignore_where`.


## icinga2 LWRP Resources

Currently icinga2 cookbook supports below Objects LWRP Resources:

- icinga2_apilistener
- icinga2_apiuser
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
- icinga2_influxdbwriter
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
```
cert_path 'SysConf + "/icinga2/pki/" + NodeName + ".crt"'

  will transform to:

cert_path SysConf + "/icinga2/pki/" + NodeName + ".crt"
```

While below attribute definition generate incorrect syntax:
```
cert_path 'SysConf + /icinga2/pki/ + NodeName + .crt'

  will transform to

cert_path SysConf + /icinga2/pki/ + NodeName + .crt
```


## icinga2 LWRP Resources Generated Object/Template File


**LWRP Resource Object Config File Location**

Icinga2 `Object` created by LWRP are stored under a separate directory `objects.d`. Directory name is configurable by node attribute `node['icinga2']['objects_d']`.

This directory is created under icinga2 config directory `node['icinga2']['conf_dir']`.

**LWRP Resource Object/Template Config File Name Convention**

LWRP generated icinga2 Objects are stored into a single file. It means each LWRP has its own conf file.

As few of LWRP can create an `Object` and `Template`, below conf file name convention is followed through out LWRP resources.

```
	Object conf file : "#{LWRP_NAME}.conf".
	Template conf file : "#{LWRP_NAME}_template.conf".
```

e.g.
```
LWRP `icinga2_host` object resources will create icinga2
`Host` objects conf file - /etc/icinga2/objects.d/host.conf

LWRP `icinga2_service` object resources will create icinga2
`Service` objects conf file - /etc/icinga2/objects.d/service.conf

LWRP `icinga2_service` template resources will create icinga2
`Service` templates conf file - /etc/icinga2/objects.d/service_template.conf

LWRP `icinga2_applyservice` resources will create icinga2
`apply Service` conf file - /etc/icinga2/objects.d/applyservice.conf
```


All LWRP generated icinga2 object/template/apply conf files are created in a single directory and managed separately.


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

```ruby
icinga2_environment 'SingaporeDevelopment' do
  import node['icinga2']['object']['host']['import']
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
```

Above LWRP resource will create `Host` objects for a chef environment nodes for a given `search_pattern` and other filter.


**LWRP Options**


- *action* (optional)	- default :create, options: :create, :delete, :reload
- *environment* (required, String) - chef environment name
- *cookbook* (optional, String)	- default icinga2, chef cookbook name for template
- *template* (optional, String)	- default object.environment.conf.erb, chef template name
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
- *limit_region* (optional, TrueClass/FalseClass)	- whether to limit chef node to chef server region, currently tested for Amazon EC2, e.g. a icinga2 server located in region `us-east-1` will only collect nodes located in `us-east-1` region
- *server_region* (optional, String)	- icinga2 server region can be overridden if cloud provider is not supported by the cookbook using this attribute
- *add_cloud_custom_vars* (optional, TrueClass/FalseClass)	- whether to add cloud attributes, currently supports amazon ec2, e.g. instance id, vpc subnet etc.
- *add_inet_custom_vars* (optional, TrueClass/FalseClass)	- whether to add inet ip address custom vars to Host objects
- *add_node_vars* (optional, Hash)	- add node attributes to custom vars, e.g. `add_node_vars 'hardware' => %w(dmi system manufacturer)` will add a custom var hardware with value of node attribute `node['dmi']['system']['manufacturer']`
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

```ruby
icinga2_envhostgroup 'envhostgroup' do
  environment environment_name
  groups %w(group)
end
```

Above LWRP resource will create `HostGroup` for a chef environment.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *environment* (name_attribute, String) - chef environment name
- *groups* (optional, Array) - host group names

Note: This LWRP resource is only meant for LWRP `environment` and not to be used for custom resources.


## LWRP icinga2_envendpoint

LWRP `envendpoint` creates an icinga `Endpoint` object for LWRP `environment` endpoints.

An `environment` endpoints are evaluated at compile time, hence it conflicts with LWRP `endpoint` resources. To avoid the conflict, LWRP `envendpoint` resources are created in a separate object file for an environment.


**LWRP Environment Endpoint example**

```ruby
icinga2_envendpoint 'envendpoint' do
  endpoints %w(endpoint)
  port 5665
  environment environment_name
  log_duration '1d'
end
```

Above LWRP resource will create `Endpoint` for a chef environment.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *environment* (name_attribute, String) - chef environment name
- *endpoints* (optional, Array)	- endpoint names
- *port* (optional, Integer) - default 5665, The service name/port of the remote Icinga 2 instance
- *log_duration* (optional, String)	- Duration for keeping replay logs on connection loss.

Note: This LWRP resource is only meant for LWRP `environment` and not to be used for custom resources.


## LWRP icinga2_envzone

LWRP `envzone` creates an icinga `Zone` object for LWRP `environment` zones.

An `environment` zones are evaluated at compile time, hence it conflicts with LWRP `zone` resources. To avoid the conflict, LWRP `envzone` resources are created in a separate object file for an environment.


**LWRP Environment Zone example**

```ruby
icinga2_envzone 'envzone' do
  zones %w(zone)
  parent 'master'
  environment environment_name
end
```


Above LWRP resource will create `Zone` for a chef environment.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *environment* (name_attribute, String) - chef environment name
- *zones* (optional, Array) - zone names
- *parent* (optional, String)	- The name of the parent zone.

Note: This LWRP resource is only meant for LWRP `environment` and not to be used for custom resources.


## LWRP icinga2_host


Unlike LWRP `environment`, LWRP `host` creates an icinga `Host` object or template.

LWRP `host` can be useful for servers not managed by Chef or to monitor Cloud Services like Amazon Elastic Cache or Amazon RDS etc.

**LWRP Host Object example**

```ruby
icinga2_host 'redis-ec.abcdef.0001.apse1.cache.amazonaws.com' do
  display_name 'Production Redis Server'
  address 'redis-ec.abcdef.0001.apse1.cache.amazonaws.com'
  custom_vars :check_tcp_ports => %w(6379), :application => 'redis', :environment => 'production', :cluster_name => 'prodredis0001'
end
```

Above LWRP resource will create an icinga `Host` object.


**LWRP Host Template example**

```ruby
icinga2_host 'generic-host' do
  template true
  max_check_attempts 5
  check_interval '1m'
  retry_interval '30s'
  check_command 'hostalive'
end
```

Above LWRP resource will create an icinga `Host` template - `generic-host`.


**LWRP Options**


- *action* (optional)	- default :create, options: :create, :delete, :reload
- *display_name* (optional, String)	- icinga `Host` object import template attribute
- *import* (optional, String)	- icinga `Host` object import template attribute
- *address* (optional, String) - icinga `Host` object import template attribute
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

```ruby
icinga2_hostgroup 'hostgroup_name' do
  display_name 'Host Group'
  groups ['othergroup']
  assign_where ['"hostgroup_name" in host.vars.hostgroups']
  ignore_where ['"hostgroup_name" in host.vars.hostgroups']
end
```

Above LWRP resource will create an icinga `HostGroup` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *display_name* (optional, String)	- icinga `HostGroup` attribute `display_name`
- *groups* (optional, Array)	- icinga `HostGroup` attribute `groups`
- *assign_where* (optional, Array) - an array of `assign where` statements
- *ignore_where* (optional, Array) - an array of `ignore where` statements


## LWRP icinga2_service


LWRP `service` creates an icinga `Service` object or template.


**LWRP Service Object example**

```ruby
icinga2_service 'redis-ec.abcdef.0001.apse1.cache.amazonaws.com_service_check' do
  display_name 'Production Redis Service Check'
  host_name 'redis-ec.abcdef.0001.apse1.cache.amazonaws.com'
  check_command 'tcp'
  custom_vars :tcp_port => 6379
end
```

Above LWRP resource will create an icinga `Service` object for a host tcp port check.


**LWRP Service Template example**

```ruby
icinga2_service 'generic-service' do
  template true
  max_check_attempts 5
  check_interval '1m'
  retry_interval '30s'
end
```

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

```ruby
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
```

Above LWRP resource will apply an icinga `Service` object to all `Hosts` with custom vars `host.vars.nrpe`.

**LWRP Apply Service For Object example**

```ruby
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
```


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

```ruby
icinga2_servicegroup 'servicegroup_name' do
  display_name 'Service Group'
  groups ['othergroup']
  assign_where ['"servicegroup_name" in host.vars.servicegroups']
  ignore_where ['"servicegroup_name" in host.vars.servicegroups']
end
```


Above LWRP resource will create an icinga `ServiceGroup` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *display_name* (optional, String)	- icinga `ServiceGroup` attribute `display_name`
- *groups* (optional, Array)	- icinga `ServiceGroup` attribute `groups`
- *assign_where* (optional, Array)	 - an array of `assign where` statements
- *ignore_where* (optional, Array)	 - an array of `ignore where` statements


## LWRP icinga2_feature

LWRP `feature` enable or disable an icinga `Feature`.


**LWRP Feature enable example**

```ruby
icinga2_feature 'feature_name'
```


Above LWRP resource will enable an icinga `Feature`.


**LWRP Feature disable example**

```ruby
icinga2_feature 'feature' do
  action :disable
end
```


Above LWRP resource will disable an icinga `Feature`.


**LWRP Options**

- *name*(name_attribute)	- icinga2 feature name
- *action* (optional)	- default :enable, options: :enable, :disable


## LWRP icinga2_user

LWRP `user` creates an icinga `User` object.


**LWRP User Object example**

```ruby
icinga2_user 'user_name' do
  import 'generic-user'
  enable_notifications true
  states %w(OK Warning Critical Unknown Up Down)
  types %w(DowntimeStart DowntimeEnd DowntimeRemoved Custom Acknowledgement Problem Recovery FlappingStart FlappingEnd)
  display_name 'User Info'
  groups %w(usergroup)
  email 'user@domain'
end
```

Above LWRP resource will create an icinga `User` object.

**LWRP User Template example**

```ruby
icinga2_user 'generic-user' do
  template true
end
```

Above LWRP resource will create an icinga `User` template.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
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

```ruby
icinga2_usergroup 'usergroup_name' do
  display_name 'User Group'
  groups ['usergroup']
  zone 'zone_name'
assign_where ['assign where statement']
ignore_where ['ignore where statement']
end
```


Above LWRP resource will create an icinga `UserGroup` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *display_name* (optional, String)	- icinga `UserGroup` attribute `display_name`
- *groups* (optional, Array)	- icinga `UserGroup` attribute `groups`
- *zone* (optional, String)	- icinga `UserGroup` attribute `zone`
- *assign_where* (optional, Array)   - an array of `assign where` statements
- *ignore_where* (optional, Array)   - an array of `ignore where` statements


## LWRP icinga2_zone

LWRP `zone` creates an icinga `Zone` object.


**LWRP Zone example**

```ruby
icinga2_zone 'zone' do
  endpoints %w(endpoint)
  parent 'parent zone'
end
```

Above LWRP resource will create an icinga `Zone` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *endpoints* (optional, String)	- icinga `Zone` attribute `endpoints`
- *parent* (optional, String)	- icinga `Zone` attribute `parent`
- *global* (optional, TrueClass/FalseClass)	- icinga `Zone` attribute `global`


## LWRP icinga2_endpoint

LWRP `endpoint` creates an icinga `Endpoint` object.


**LWRP Endpoint example**

```ruby
icinga2_endpoint 'endpoint' do
  host 'host address'
  port 1234
  log_duration 'log duration'
end
```


Above LWRP resource will create an icinga `Endpoint` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *host* (optional, String)	- icinga `Endpoint` attribute `host`
- *port* (optional, Integer)	- icinga `Endpoint` attribute `port`
- *log_duration* (optional, String)	- icinga `Endpoint` attribute `log_duration`


## LWRP icinga2_timeperiod

LWRP `timeperiod` creates an icinga `TimePeriod` object.


**LWRP TimePeriod example**

```ruby
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
```


Above LWRP resource will create an icinga `TimePeriod` object.

**LWRP TimePeriod template**

```ruby
icinga2_timeperiod 'legacy-timeperiod' do
  template true
  display_name 'legacy-timeperiod'
end
```

Above LWRP resource will create an icinga `TimePeriod` template.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *display_name* (optional, String)	- icinga `TimePeriod` attribute `display_name`
- *import* (optional, String)	- icinga `TimePeriod` attribute `import`
- *zone* (optional, String)	- icinga `TimePeriod` attribute `zone`
- *ranges* (optional, Hash)	- icinga `TimePeriod` attribute `ranges`
- *template* (optional, TrueClass/FalseClass)	- whether to create an icinga `TimePeriod` template


## LWRP icinga2_eventcommand

LWRP `eventcommand` creates an icinga `EventCommand` object.


**LWRP EventCommand example**

```ruby
icinga2_eventcommand 'eventcommand' do
  command 'command name'
  custom_vars :attribute => 'value'
end
```


Above LWRP resource will create an icinga `EventCommand` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *import* (optional, String)	- icinga `EventCommand` attribute `import`
- *command* (optional, String/Array)	- icinga `EventCommand` attribute `command`
- *env* (optional, Hash)	- icinga `EventCommand` attribute `env`
- *timeout* (optional, String/Integer)	- icinga `EventCommand` attribute `timeout`
- *arguments* (optional, Hash)	- icinga `EventCommand` attribute `arguments`
- *custom_vars* (optional, Hash)	- icinga `EventCommand` attribute `custom_vars`


## LWRP icinga2_checkcommand


LWRP `checkcommand` creates an icinga `CheckCommand` object.


**LWRP CheckCommand example**

```ruby
icinga2_checkcommand 'checkcommand' do
  command 'command name'
  env :attribute => 'value'
  arguments :attribute => 'value'
  custom_vars :attribute => 'value'
  zone 'zone name'
end
```


Above LWRP resource will create an icinga `CheckCommand` object.


**LWRP Options**

- *action* (optional, String)	- default :create, options: :create, :delete
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

```ruby
icinga2_scheduleddowntime 'downtime' do
  host_name 'host name'
  service_name 'service name'
  author 'author'
  comment 'comment'
  duration 'duration'
end
```


Above LWRP resource will create an icinga `ScheduledDowntime` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
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

```ruby
icinga2_script 'mail-host-notification-custom.sh' do
  cookbook 'wrapper_cookbook'
  source 'mail-host-notification-custom.sh.erb'
end
```


Above LWRP resource will create a script file under `node['icinga2']['scripts_dir']/mail-host-notification-custom.sh` using template `mail-host-notification-custom.sh.erb` from cookbook `wrapper_cookbook`.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *source* (optional, String)	- default :name, template resource attribute `source`
- *cookbook* (required, String)	- template resource attribute `cookbook`
- *variables* (optional, Hash)	- template resource attribute `variables`


## LWRP icinga2_externalcommandlistener

LWRP `externalcommandlistener` creates an icinga `ExternalCommandListener` object.


**LWRP ExternalCommandListener example**

```ruby
icinga2_externalcommandlistener 'externalcommandlistener' do
  library 'library'
  command_path 'command path'
end
```


Above LWRP resource will create an icinga `ExternalCommandListener` config object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *library* (optional, String)	- default 'compat', icinga `ExternalCommandListener` attribute `library`
- *command_path* (optional, String)	- icinga `ExternalCommandListener` attribute `command_path`


## LWRP icinga2_gelfwriter

LWRP `gelfwriter` creates an icinga `GelfWriter` object.


**LWRP GelfWrite example**

```ruby
icinga2_gelfwriter 'gelfwriter' do
  library 'library'
  host 'host address'
  port 1234
  source 'source'
end
```


Above LWRP resource will create an icinga `GelfWriter` config object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *library* (optional, String)	- default 'perfdata', icinga `GelfWriter` attribute `library`
- *host* (required, String)	- icinga `GelfWriter` attribute `host`
- *port* (required, Integer)	- icinga `GelfWriter` attribute `port`
- *source* (optional, String)	- icinga `GelfWriter` attribute `source`


## LWRP icinga2_graphitewriter

LWRP `graphitewriter` creates an icinga `GraphiteWriter` object.


**LWRP GraphiteWriter example**

```ruby
icinga2_graphitewriter 'graphitewriter' do
  library 'library'
  host 'host address'
  port 1234
end
```


Above LWRP resource will create an icinga `GraphiteWriter` config object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *library* (optional, String)	- default 'perfdata', icinga `GraphiteWriter` attribute `library`
- *host* (optional, String)	- icinga `GraphiteWriter` attribute `host`
- *port* (optional, Integer)	- icinga `GraphiteWriter` attribute `port`
- *host_name_template* (optional, String)	- default icinga.$host.name$, icinga `GraphiteWriter` attribute `host_name_template`
- *service_name_template* (optional, String)	- default icinga.$host.name$.$service.name$, icinga `GraphiteWriter` attribute `service_name_template`


## LWRP icinga2_influxdbwriter

LWRP `influxdbwriter` creates an icinga `InfluxdbWriter` object.


**LWRP InfluxdbWriter example**

```ruby
icinga2_influxdbwriter 'influxdbwriter' do
  library 'library'
  host 'host address'
  port 8087
  database 'icinga2'
  username 'myuser'
  password 'mypassword'
end
```


Above LWRP resource will create an icinga `InfluxdbWriter` config object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *library* (optional, String)	- default 'perfdata', icinga `InfluxdbWriter` attribute `library`
- *host* (optional, String)	- default 'localhost', icinga `InfluxdbWriter` attribute `host`
- *port* (optional, Integer)	- default 8087, icinga `InfluxdbWriter` attribute `port`
- *database* (optional, String)	- default 'icinga2', icinga `InfluxdbWriter` attribute `database`
- *username* (optional, String)	- icinga `InfluxdbWriter` attribute `username`
- *password* (optional, String)	- icinga `InfluxdbWriter` attribute `password`
- *ssl_enable* (optional, String)	- default 'false', icinga `InfluxdbWriter` attribute `ssl_enable`
- *ssl_ca_cert* (optional, String)	- icinga `InfluxdbWriter` attribute `ssl_ca_cert`
- *ssl_cert* (optional, String)	- icinga `InfluxdbWriter` attribute `ssl_cert`
- *ssl_key* (optional, String)	- icinga `InfluxdbWriter` attribute `ssl_key`
- *host_template* (optional, String)	- icinga `InfluxdbWriter` attribute `host_template`
- *service_template* (optional, String)	- icinga `InfluxdbWriter` attribute `service_template`
- *enable_send_thresholds* (optional, String)	- icinga `InfluxdbWriter` attribute `enable_send_thresholds`
- *enable_send_metadata* (optional, String)	- icinga `InfluxdbWriter` attribute `enable_send_metadata`
- *flush_intervald* (optional, String)	- icinga `InfluxdbWriter` attribute `flush_intervald`
- *flush_threshold* (optional, Integer)	- icinga `InfluxdbWriter` attribute `flush_threshold`


## LWRP icinga2_idomysqlconnection

LWRP `idomysqlconnection` creates an icinga `IdoMySqlConnection` object.


**LWRP IdoMySqlConnection example**

```ruby
icinga2_idomysqlconnection 'idomysqlconnection' do
  library 'library'
  host 'host address'
  port 1234
  user 'user name'
  password 'password'
  database 'database name'
end
```


Above LWRP resource will create an icinga `IdoMySqlConnection` config object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
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

```ruby
icinga2_idopgsqlconnection 'idopgsqlconnection' do
  library 'library'
  host 'host address'
  port 1234
  user 'user name'
  password 'password'
  database 'database name'
end
```


Above LWRP resource will create an icinga `IdoPgSqlConnection` config object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
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

```ruby
icinga2_sysloglogger 'sysloglogger' do
  severity 'critical'
end
```


Above LWRP resource will create an icinga `SyslogLogger` object.


**LWRP Options**

- *name*(name_attribute)	- icinga `SyslogLogger` name
- *severity* (optional, String)	- icinga `SyslogLogger` attribute `port`


## LWRP icinga2_notification


LWRP `notification` creates an icinga `Notification` object.


**LWRP Notification Object example**

```ruby
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
```



Above LWRP resource will create an icinga `Notification` object.

**LWRP Notification Template example**

```ruby
icinga2_notification 'notification' do
  template true
  period '24x7'
end
```


Above LWRP resource will create an icinga `Notification` template.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
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

```ruby
icinga2_applynotification 'servicenotification' do
  object_type 'Service'
  command 'mail-service-notification'
  users %w(user)
  interval '1h'
  assign_where ['host.address && host.vars.environment == "development"']
  ignore_where ['host.vars.monitoring_disabled == true']
end
```




Above LWRP resource will apply `Notification` to all `Service` objects for provided `assign where` statements and ignore for specified `ignore where` statements.

**LWRP apply Notification Host Object example**

```ruby
icinga2_applynotification 'hostnotification' do
  object_type 'Host'
  command 'mail-host-notification'
  users %w(user)
  interval '1h'
  assign_where ['host.address && host.vars.environment == "development"']
  ignore_where ['host.vars.monitoring_disabled == true']
end
```

Above LWRP resource will apply `Notification` to all `Host` objects for provided `assign_where` statements and ignore for specified `ignore_where` statements.


**LWRP Options**

- *object_type* (required, String)	- apply Notification to `Host` or `Service`, valid values are: Host Service
- *action* (optional, String)	- default :create, options: :create, :delete
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

```ruby
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
```

Above LWRP resource will create an icinga `NotificationCommand` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
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

```ruby
icinga2_apilistener 'master' do
  cert_path 'SysconfDir + "/icinga2/pki/" + NodeName + ".crt"'
  key_path 'SysconfDir + "/icinga2/pki/" + NodeName + ".key"'
  ca_path 'SysconfDir + "/icinga2/pki/ca.crt"'
  bind_host 'host address'
  bind_port '5665'
  ticket_salt 'TicketSalt'
end
```


Above LWRP resource will create an icinga `ApiListener` object.


**LWRP Options**

- *action* (optional, String)	- default :create, options: :create, :delete
- *cert_path* (required, String)	- icinga `ApiListener` attribute `cert_path`
- *key_path* (required, String)	- icinga `ApiListener` attribute `key_path`
- *ca_path* (required, String)	- icinga `ApiListener` attribute `ca_path`
- *crl_path* (optional, String)	- icinga `ApiListener` attribute `crl_path`
- *bind_host* (optional, String)	- icinga `ApiListener` attribute `bind_host`
- *bind_port* (optional, String)	- icinga `ApiListener` attribute `bind_port`
- *ticket_salt* (optional, String)	- icinga `ApiListener` attribute `ticket_salt`
- *accept_config* (optional, TrueClass/FalseClass)	- icinga `ApiListener` attribute `accept_config`
- *accept_commands* (optional, TrueClass/FalseClass)	- icinga `ApiListener` attribute `accept_commands`


## LWRP icinga2_apiuser

LWRP `apiuser` creates an icinga `ApiUser` object.


**LWRP ApiUser example**

```ruby
icinga2_apiuser 'master' do
  password 'mysecretapipassword'
  client_cn 'myname'
  permissions '["*"]'
end
```


Above LWRP resource will create an icinga `apiuser` object.


**LWRP Options**

- *action* (optional, String) - default :create, options: :create, :delete
- *password* (required, String) - icinga `apiuser` attribute `password`
- *permissions* (required, String) - icinga `apiuser` attribute `permissions`
- *client_cn* (optional, String) - icinga `apiuser` attribute `client_cn`


## LWRP icinga2_livestatuslistener

LWRP `livestatuslistener` creates an icinga `LiveStatusListener` object.


**LWRP LiveStatusListener example**

```ruby
icinga2_livestatuslistener 'livestatuslistener' do
  socket_type 'socket type'
  socket_path 'socket path'
  bind_host 'host address'
  bind_port 'host port'
  compat_log_path 'log path'
end
```


Above LWRP resource will create an icinga `LiveStatusListener` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *socket_type* (optional, String)	- icinga `LiveStatusListener` attribute `socket_type`
- *socket_path* (optional, String)	- icinga `LiveStatusListener` attribute `socket_path`
- *bind_host* (optional, String)	- icinga `LiveStatusListener` attribute `bind_host`
- *bind_port* (optional, Integer)	- icinga `LiveStatusListener` attribute `bind_port`
- *compat_log_path* (optional, String)	- icinga `LiveStatusListener` attribute `compat_log_path`



## LWRP icinga2_statusdatawriter

LWRP `statusdatawriter` creates an icinga `StatusDataWriter` object.


**LWRP StatusDataWriter example**

```ruby
icinga2_statusdatawriter 'statusdatawriter' do
  status_path 'status path'
  objects_path 'objects path'
  update_interval 'update interval'
end
```


Above LWRP resource will create an icinga `StatusDataWriter` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *library* (optional, String)	- default compat, icinga `StatusDataWriter` Object `library`
- *status_path* (optional, String)	- icinga `StatusDataWriter` attribute `status_path`
- *objects_path* (optional, String)	- icinga `StatusDataWriter` attribute `objects_path`
- *update_interval* (optional, String/Integer)	- icinga `StatusDataWriter` attribute `update_interval`



## LWRP icinga2_compatlogger

LWRP `compatlogger` creates an icinga `CompatLogger` object.


**LWRP CompatLogger example**

```ruby
icinga2_compatlogger 'compatlogger' do
  log_dir 'log dir'
  rotation_method 'rotation method'
end
```


Above LWRP resource will create an icinga `CompatLogger` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *library* (optional, String)	- default compat, icinga `CompatLogger` Object `library`
- *log_dir* (optional, String)	- icinga `CompatLogger` attribute `log_dir`
- *rotation_method* (optional, String)	- icinga `CompatLogger` attribute `rotation_method`



## LWRP icinga2_checkresultreader

LWRP `checkresultreader` creates an icinga `CheckResultReader` object.


**LWRP CheckResultReader example**

```ruby
icinga2_checkresultreader 'checkresultreader' do
  spool_dir 'spool dir'
end
```


Above LWRP resource will create an icinga `CheckResultReader` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *library* (optional, String)	- default compat, icinga `CheckResultReader` Object `library`
- *spool_dir* (optional, String)	- icinga `CheckResultReader` attribute `spool_dir`



## LWRP icinga2_notificationcomponent

LWRP `notificationcomponent` creates an icinga `NotificationComponent` object.


**LWRP NotificationComponent example**

```ruby
icinga2_notificationcomponent 'notificationcomponent'
```



Above LWRP resource will create an icinga `NotificationComponent` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *library* (optional, String)	- default notification, icinga `NotificationComponent` Object `library`
- *enable_ha* (optional, String)	- icinga `NotificationComponent` attribute `enable_ha`


## LWRP icinga2_filelogger

LWRP `filelogger` creates an icinga `FileLogger` object.


**LWRP FileLogger example**

```ruby
icinga2_filelogger 'filelogger'
```

Above LWRP resource will create an icinga `FileLogger` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *path* (optional, String)	- icinga `FileLogger` attribute `path`
- *severity* (optional, String)	- icinga `FileLogger` attribute `severity`


## LWRP icinga2_perfdatawriter

LWRP `perfdatawriter` creates an icinga `PerfdataWriter` object.


**LWRP PerfdataWriter example**

```ruby
icinga2_perfdatawriter 'perfdatawriter' do
  host_perfdata_path 'host perfdata path'
  service_perfdata_path 'service perfdata path'
  host_format_template 'host perfdata format'
  service_format_template 'service perfdata format'
  rotation_interval 'rotation interval'
end
```


Above LWRP resource will create an icinga `PerfdataWriter` object.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
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

```ruby
icinga2_applydependency 'applyservicedependency' do
  object_type 'Service'
  parent_service_name 'check_nrpe'
  states %w(OK Critical Unknown Warning)
  period '24x7'
  assign_where ['service.check_command == "nrpe"']
  ignore_where ['service.name == "check_nrpe"']
end
```

Above LWRP resource will apply `Dependency` to all `Service` objects for provided `assign where` statements and ignore for specified `ignore where` statements.

**LWRP apply Dependency Host Object example**

```ruby
icinga2_applydependency 'applyhostdependency' do
  object_type 'Host'
  parent_host_name 'gateway host'
  states %w(Down Unknown)
  period '24x7'
  assign_where %w(host.address)
  ignore_where ['!host.address']
end
```

Above LWRP resource will apply `Dependency` to all `Host` objects for provided `assign_where` statements and ignore for specified `ignore_where` statements.


**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
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


[Icinga2]: https://www.icinga.org/
[Chef]: https://www.chef.io/
[Install]: https://github.com/icinga/icinga2/
[Dev Icinga]: https://dev.icinga.org/projects/chef-icinga2
[Register]: https://www.icinga.org/register/
