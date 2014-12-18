icinga2 CHANGELOG
=================

This file is used to list changes made in each version of the icinga2 cookbook.

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
