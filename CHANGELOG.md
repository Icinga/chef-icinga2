icinga2 CHANGELOG
=================

This file is used to list changes made in each version of the icinga2 cookbook.
2.6.6
-----

- Jo Rhett - Allow the use of packages for icingaweb2 interface, provide more control of git checkout

2.6.5
-----

- Virender Khatri - Bug #9724, unable to create checkcommand templates via the cookbook

- Virender Khatri - Feature #9737, Add a note for Production Environment Usage

- Virender Khatri - Bug #9738, enable ITL for resource eventcommand

- Virender Khatri - Bug #9764, enable ITL for resource notificationcommand

- Virender Khatri - Bug #9805, udpate resources to match all possible values for resource.action

- Virender Khatri - Bug #9807, Documentation change - icinga2_script says cookbook optional but it is mandatory

- Virender Khatri - Bug #9809, bump icinga2 version to v2.3.8-1 and 1.13.3-0

2.5.7
-----

- Virender Khatri - Feature #9638, bump icingaweb2 release to v2.0.0-rc1

- Virender Khatri - Feature #9639, bump icinga2 version to v2.3.7

2.5.5
-----

- Martin Stiborsky - Feature #9492, Node name added as a option for host display name for environment resource

- Virender Khatri - Bug #9488, evaluate string for icinga2 function

- Virender Khatri - Bug #9488, Functions as Custom Attribute doesnt work with custom_vars for checkcommand resource

2.5.2
-----

- Martin Stiborsky - Updated README for LWRP examples typo fix

- Virender Khatri - Feature #9457, bump icinga2 version to 2.3.5-1

2.5.0
-----

- Virender Khatri - Bug #9173, update LWRP environment & README for monitoring_off

- Virender Khatri - Bug #9174, make Host Object atttribute display_name configurable for LWRP environment

- Virender Khatri - Bug #9194, sort aws host custom_vars attribute node_security_groups

- Virender Khatri - Bug #9193, recipe server needs to include server_config

- Virender Khatri - Bug #9195, sort groups attribute for resources icinga2 Objects

- Steven De Coeyer - Update repo.rb typo

- Steven De Coeyer - Add debian to, and reorders icinga2.apache_modules

- Steven De Coeyer - Add debmon prefix to distribution for debian paltform family

- Steven De Coeyer - Fix apt key for debmon repos

- Steven De Coeyer - Add tests for icingaweb2

- Steven De Coeyer - Fix version of packages for debian paltform family

- Steven De Coeyer - Fix missing nagios user for ubuntu

- Frederik Thuysbaert & Steven De Coeyer - Add set attribute to support 'apply Service for'

- Frederik Thuysbaert & Steven De Coeyer - Adds evaluate_quotes method in favor of inspect

- Frederik Thuysbaert - Update README to include Apply Service For

- Virender Khatri - Bug #9370, fix nagios user group for ubuntu platform

- Martin Stiborsky - Updated README.md for resource attribute port to be integer

- Steven De Coeyer - Allows underscores in set attribute for resource applyservice

- Virender Khatri - Feature #9299 add icinga2_script resource to add scripts from wrapper cookbook templates


2.3.1
-----

- Virender Khatri - Bug #9037, added Hash support for host / service custom vars

- Virender Khatri - Bug #9019, fixed host.vars.disks attribute for lwrp environment

- Virender Khatri - Bug #9038, added suffix centos for epel repo releasever 7

- Marcel Beck - Bug #9038, rhel version check for centos suffix

- Marcel Beck - Bug #9039, allow web_uri /

- Virender Khatri - Bug #9066, allow arguments Hash key value to be String, Integer and Float for checkcommand lwrp

- Virender Khatri - Bug #8788, possible fix for debian platform classic_ui cgi resource_file nil string

- Virender Khatri - Bug #9126, manage classic ui cgi log directory

- Virender Khatri - Bug #9125, update repo attribute to support debian platform

- Virender Khatri - Bug #9128, fix user group ownership for node[icinga2][classic_ui][log_dir]

- Virender Khatri - Bug #9129, classic ui unable to access icinga2 objects.cache on ubuntu platform

- Jörg Herzinger - Bug #9132,Fix version contraint for centos 7 apache modules

- Virender Khatri - Bug #9151, bump icinga2 version to v2.3.4-1, classic_ui version to v1.13.2

2.1.8
-----

- Virender Khatri - Bug #9001, added attribute to ignore default icinga2 package version

2.1.7
-----

- Virender Khatri - Feature #8997, bump update icinga2 version to v2.3.3

2.1.6
-----

- Virender Khatri - Feature #8630, adding default Host vars remote_client

- Virender Khatri - Feature #8631, add default endpoint port

- Virender Khatri - Bug #8635, re-org recipes in favour of client agent recipe

- Virender Khatri - Bug #8837, restart icinga2 service on package upgrade / install

- Virender Khatri - Bug #8838, bump icinga2 version to v2.3.2

- Virender Khatri - Bug #8838, bump icingaweb2 ref to beta3


2.1.0
-----

- Virender Khatri - iBug #8449 update default icingaweb2 version to use tag release

- Virender Khatri - iBug #8409 bump icinga2 version

- Virender Khatri - iFeature #8454, enable snapshot yum repository

- Andrei Scopenco - allow to disable user_defined_objects_dir

- Virender Khatri - iBug #8479 use packages.icinga.org for apt/yum snapshots repository

- Virender Khatri - iBug #8481 use native htpasswd file location for icinga2 classicui

- Virender Khatri - iBug #8469 mod_python deprecated for centos7/rhel7

- Jannik Zinkl - iBug #8469, fixed platform_version condition

- Virender Khatri - iBug #8494 package php5-intl added for ubuntu

- Virender Khatri - iBug #8495 fix for libjpeg62-dev conflict with libgd2-xpm-dev

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
