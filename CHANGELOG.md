icinga2 CHANGELOG
=================

This file is used to list changes made in each version of the icinga2 cookbook.

2.0.1
-----

- Jannik Zinkl - fixed pgqsl schema setup for extra line char

- Andrei Scopenco - iBug #8384 fix for LWRP endpoint

- Virender Khatri - iBug #8384 fix for lwrp apilistener

- Virender Khatri - iBug #8384 fix for lwrp applydependency

- Virender Khatri - iBug #8384 fix for lwrp applynotification

- Virender Khatri - iBug #8384 fix for lwrp applyservice

- Virender Khatri - iBug #8384 fix for lwrp checkcommand

- Virender Khatri - iBug #8384 fix for lwrp eventcommand

- Virender Khatri - iBug #8384 fix for lwrp hostgroup

- Virender Khatri - iBug #8384 fix for lwrp notificationcommand

- Virender Khatri - iBug #8384 fix for lwrp servicegroup

- Virender Khatri - iBug #8384 fix for lwrp usergroup

- Virender Khatri - iBug #8384 fix for lwrp zone

- Jannik Zinkl - iBug #8377 fixing package php-pecl-imagick install for imagick

- Virender Khatri - iBug #8377 added yum-epel repository for package php-pecl-imagick

- Andrei Scopenco - added include_itl attribute for adding itl to icinga2.conf

- Virender Khatri - iBug #8419 updated icinga web2 default uri to /icingaweb2

- Virender Khatri - iBug #8377 added icingaweb2 packages dependency for debian platform family

- Andrei Scopenco - iBug #8427 added attribute for disabling repository.d

- Andrei Scopenco - iBug #8428 added lwrp zone resource attribute - global


0.10.1
-----

- Gerhard Sulzberger - corrected platform_family case statement in recipe `server_os_packages` & `server_install`

- Virender Khatri - bump icinga2 version to 2.2.3-1

- Virender Khatri - corrected LWRP applydependency resource attribute Class type

- Virender Khatri - removed object_name LWRP applyservice resource attribute

- Virender Khatri - fixed LWRP for resource attribute `port`

- Virender Khatri - added LWRP resource Class to README

- Virender Khatri - fixed server isntall attributes & recipes

- Gerhard Sulzberger - added recipe `apt` for deb packages upgrade dependency

- Gerhard Sulzberger - added icinga user & group for debian platform family

- Virender Khatri - added icinga cmdgroup for debian platform family

- Virender Khatri - fixed typo for apache node attribute reference

- Virender Khatri - updated apache vhost template

- Virender Khatri - added attribute for optional configuration of icinga2 classic ui & web2

- Virender Khatri - fixed classic ui template & attributes for ubuntu / deb paltform family

- Virender Khatri - allow LWRP environment chef resources override with custom template
                    added LWRP attributes for custom resources attributes for icinga2 Host/HostGroup template

- Andrei Scopenco - fixed package version suffix for release repo

- Andrei Scopenco - fixed typos in LWRP idomysqlconnection

- Andrei Scopenco - fixed typos and template in LWRP externalcommandlistener

- Virender Khatri - fixed missing library template attribute for LWRP compatlogger

- Virender Khatri - corrected icinga2 object name for LWRP idomysqlconnection

- Virender Khatri - corrected icinga2 object name for LWRP idopgsqlconnection

- Virender Khatri - corrected icinga2 object name for LWRP livestatuslistener

- Virender Khatri - deprecated features mgmt via node attr in favor of LWRP

- Virender Khatri - fixed interval / timeout object attribute in resource templates

- Jannik Zinkl - fixed typo in recipe server_ido_schema.rb

0.7.6
-----

- Virender Khatri - LWRP resource custom vars are not sorted

- Virender Khatri - updated generic-host template to use node attributes

- Virender Khatri - cleaned up LWRP for unused attributes

- Virender Khatri - added LWRP applydependency

- Virender Khatri - fixed error for missing node attribute in library

- Virender Khatri - fixed LWRP applyservice template for True/False Class attributes

- Virender Khatri - updated README

0.7.0
-----

- Virender Khatri - added multiple zone support for LWRP environment

0.6.8
-----

- Virender Khatri - fixed ido schema upload recipe

- Virender Khatri - added icingaweb2 apache nginx vhost

- Virender Khatri - created different recipe for os packages install

- Virender Khatri - added icingaweb2 setup and configuration

- Virender Khatri - added icingaweb2 setup token attribute

- Virender Khatri - fixed LWRP apilistener

0.6.1
-----

- Virender Khatri - added travis

- Virender Khatri - added user_defined_objects conf directory

- Virender Khatri - added LWRP resource regex check for interval attributes

- Virender Khatri - fixed LWRP template for gelfwriter graphitewriter  idomysqlconnection
                    idopgsqlconnection sysloglogger sysloglogger

- Virender Khatri - added LWRP compatlogger livestatuslistener perfdatawriter
                    statusdatawriter checkercomponent checkresultreader filelogger
                    notificationcomponent

- Virender Khatri - updated README doc

0.5.4
-----

- Virender Khatri - added pnp4nagios ssi symlink for node graph preview

- Virender Khatri - fixed library for mount disks host custom vars

- Virender Khatri - fixed LWRP sysloglogger

- Virender Khatri - added LWRP doc

0.5.0
-----

- Virender Khatri - added lwrp for icinga2 feature

- Virender Khatri - removed default features

- Virender Khatri - added default `NodeName` constant

- Virender Khatri - removed zones.conf in favor of LWRP `zone`

- Virender Khatri - delaying icinga2 service start in favor of LWRP resources objects

- Virender Khatri - added missing zone Object to various environment / host LWRPs

- Virender Khatri - corrected LWRP endpoint

- Virender Khatri - added support for pnp4nagios

- Virender Khatri - updated README documentation


0.4.2
-----

- Virender Khatri - removed nrpe client recipe

- Virender Khatri - replaced icingaweb recipe from cookbook with icingaweb2

- Virender Khatri - refactored recipes for packages

- Virender Khatri - prepping for pnp4nagios support, added recipe `icinga2::server_pnp`

- Virender Khatri - disabled icingaweb2 by default

- Virender Khatri - enable icinga2 classic ui by default

- Virender Khatri - disabled pnp integration by defatul

- Virender Khatri - renamed `conf.d` disable attribute to `disable_conf_d`

- Virender Khatri - added `icinga2_features` recipe to manage icinga2 features

- Virender Khatri - removed `environment` lwrp attribute `env_notification_user_groups`

- Virender Khatri - bump icinga2 version to v2.2.2-1

- Virender Khatri - preparing for `ubuntu` platform testing

0.3.0
-----

- Virender Khatri - allowing node custom_vars hostgroups Array declaration

- Virender Khatri - corrected check_interval chec_period resource attribute type

- Virender Khatri - renamed downtime lwrp to scheduleddowntime

- Virender Khatri - added applistener lwrp

- Virender Khatri - added endpoint lwrp

- Virender Khatri - added gelfwrite lwrp

- Virender Khatri - corrected lwrp attributes types

- Virender Khatri - corrected icinga2 objects boolean attribute, nil value attribute will be ignored

- Virender Khatri - fixed mail notification scripts permissions

0.2.1
-----

- Virender Khatri - removed files under development for chef supermarket

0.2.0
-----

- Virender Khatri - added node cpu and memory to custom vars by default

- Virender Khatri - fixed permission issue on /var/run/icinga2

- Virender Khatri - fixed nrpe config for ubuntu

- Virender Khatri - added templates for mail notification scripts

- Virender Khatri - added externalcommandlistener lwrp

- Virender Khatri - added graphitewriter lwrp

- Virender Khatri - added idomysqlconnection lwrp

- Virender Khatri - added idopgsqlconnection lwrp

- Virender Khatri - added sysloglogger lwrp

- Virender Khatri - renamed client recipe to client_nrpe in favor of icinga2 agent

0.1.5
-----

- Virender Khatri - initial release of icinga2

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
