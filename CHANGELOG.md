icinga2 CHANGELOG
=================

This file is used to list changes made in each version of the icinga2 cookbook.

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
