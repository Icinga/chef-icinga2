icinga2 CHANGELOG
=================

This file is used to list changes made in each version of the icinga2 cookbook.

4.0.0
-----

- Andrei Skopenko - Fix icinga2 package suffix for el7

- Andrei Skopenko - Bump icinga2 version

- Virender Khatri - Split cookbook to separate cookbooks

- Virender Khatri - Created cookbook `icinga2client` for Icinga2 Clients

- Virender Khatri - Created cookbook `icingaweb2` for Icingaweb2

- Virender Khatri - Created cookbook `icinga2repo` for Icinga2 YUM/APT Repository

3.0.1
-----

- Andrei Skopenko - FixHost object command_endpoint

- Alex Markessinis - Updated chocolatey dependency

- Andrei Skopenko - Fix icinga2 cache dir

- Andrei Skopenko - Added influxdbwriter object

3.0.0
-----

- Bernhard Hackl - Fix NoMethodError in provider_instance

- Peter Phillips - Added resources attribute notification_period

- Bernhard Hackl - Added raspbian support

- Virender Khatri - Documentation clean up for issue #265

- Virender Khatri - Enabled travis kitchen tests with chefdk #281

- David Beck - Updated documentation #285

- Thomas Farvour - Added new attribute enable_role_hostgroup for environment + role hostgroup #286

- Thomas Farvour - Pin chef omnibus version so that Chef 13 doesn't break all the tests

- Thomas Farvour - Fixed hostgroup for roles

- Thomas Farvour - Added attribute enable_env_custom_pki to skip PKI setup

- Techcadia - Added windows support

- Techcadia - Added directory resources for repository.d

- Michael Siebert - Allow "item in host.vars.bar" syntax in icinga2_applyservice #287

- Michael Friedrich - Add GitHub issue template #288

- Techcadia - Updated service object template to use evaluate_quotes

- Techcadia - Updated README for weird syntax and space

- Bernhard Hackl - Fixed run_context null value return issue

- Vil Surkin - Fix Trusty package version

- Vil Surkin - Updated specs

- Vil Surkin - Disabled apt install_recommends, install libapache2-mod-php5 only for ubuntu trusty

- Vil Surkin - Added 'icinga2-test-mysql-instance' and updated kitchen tests

- Vil Surkin - Added specs for icingaweb2

- Vil Surkin - Added specs for classicui

- Vil Surkin - Updated kitchen dokken tests

- Vil Surkin - Switch from rubocop to cookstyle

- Vil Surkin - Fix lint

- Thomas Farvour - Updated icinga2 package version to 2.7.0

- Virender Khatri - Switch to server_api for Chef 13, fix for #284

- Virender Khatri - Fixed Debian9 kitchen test, gnupg dependency

- Virender Khatri - Added Amazon Platform family support

- Virender Khatri - Pin Travis chefdk=2.0.28-1

- Andrei Skopenko - Added LWRP icinga2_apiuser

- Andrei Skopenko - Added cookbook source for apache conf templates


2.9.3
-----

- Virender Khatri - use php7 for ubuntu xenial #269, #69

- Virender Khatri - fix ubuntu package version, reverted change by #267


2.9.2
-----

- Virender Khatri - Added .ignore directory to ignore

- Cody Sandwith - Fixes references to PHP Aptitude package names and paths, to support Ubuntu 16.04

- Cody Sandwith - Fixed PHP.ini's location and date_timezone attribute

- Cody Sandwith - Added icinga web2 packages release version

- Cody Sandwith - Cleaned up Aptitude/Yum package declarations

- Cody Sandwith - Updated recipes to be more compatible with lint, and cleaned up comments

- JJ Asghar - Rubocop fix

- Ankit Rusia - Fix missing parent attribute for icinga2_envzone

- Blerim Sheqa - Ignore rubocop BlockLenth

- Frederik Thuysbaert - Makes wrapping possible of the object templates that belong to Icinga2Instance resources

- Blerim Sheqa - Fix Rubocop again

- Virender Khatri - fixed specs for trusty

- Jeroen Jacobs - PR #241, Updates the web2 git source url

- Cody Sandwith - PR #246, Ubuntu 16.04 Compatibility updates

- Virender Khatri - PR #247, rubocop fix

- Virender Khatri - Issue #249, should fail if os detail is unknown for php.ini file location

- Virender Khatri - PR #252, fixed typo for web2_version check

- Virender Khatri - PR #253, allow ignore version for icingaweb2 and icingacli packages

- Virender Khatri - Issue #244, set default timezone value UTC if missing

- Virender Khatri - Issue #256, remove default git package for rhel platform_family

- Virender Khatri - Issue #245, #242, Fixed icingacli version install error

- Virender Khatri - Updated Packages version to latest

- Virender Khatri - Issue #258, set apache2 default mpm to prefork for ubuntu

- Virender Khatri - Updated Kitchen

- Virender Khatri - Issue #236, default disable default icinga2 conf directory

- Virender Khatri - Issue #255, support debian platform

- Virender Khatri - Issue #255, fixed kitchen debian os version

- Virender Khatri - Issue #262, use dependency cookbooks latest version

- Virender Khatri - Issue #267, update packages version to 2.6.1

- Virender Khatri - Issue #266, Updated kitchen to allow ports override


2.9.1
-----

- Blerim Sheqa - Ignore foodcritic FC057

- Virender Khatri - Feature #12785, update to latest package release

- Virender Khatri - Bug #12609 fix, cannot do core_install on Ubuntu 14 LTS

- Virender Khatri - Fix ido setup, require mysql client to load schema

- Virender Khatri - Bug #12787, include recipe service_ido_schema only if node[icinga2][ido][load_schema]

- Virender Khatri - Bug #12788, do not include recipe server_pnp unless classis_ui and pnp

- Virender Khatri - Updated kitchen

- Virender Khatri - Bug #12794, add db port to ido schema load

- Virender Khatri - Bug #12795, deprecate node.set

- Virender Khatri - Bug #12796, disable classic_ui by default

- Virender Khatri - Added package installation for icingaweb2

- Virender Khatri - Updated packages version

- JJ Asghar - Fix Rubocop for Ruby3

2.9.0
-----

- Gavin Reynolds - Allow re-notifications to be disabled by allowing the value 0 in the interval regex for applynotification

- Blerim Sheqa - Add TESTING.md

- Blerim Sheqa - Update integration testing

- Blerim Sheqa - Add centos to testkitchen platforms

- JJ Asghar - Fix rubocop

- Gavin Reynolds - Add user and group attributes to logrotate conf

- Virender Khatri - setup pki env zone endpoint resources if node[icinga2][enable_env_pki] is enabled

- Virender Khatri - update server_region with cloud provider only if new_resource.server_region is not set

- Virender Khatri - Should check resource for template_support first

- Virender Khatri - Fix amazon linux apache modules

- Virender Khatri - Fix default[icinga2][plugins_dir] value

- Virender Khatri - Added issues_url in metadata

- Virender Khatri - Update travis to User Ruby v2.2

- Gavin Reynolds - Add merge_vars attribute to applyservice and allow for multiple Service definitions for set by adding service name prefix

- Gavin Reynolds - Use platform family debian for both Debian and Ubuntu

- Gavin Reynolds - Fix icinga2_classic_ui_htpasswd path for debian

- Thomas Supertramp - Feature #11834, Add lwrp envendpoint / envzone lwrp for environment resource

- Thomas Supertramp - Feature #11958, Add pki ticket generation through chef_environment lwrp

- Thomas Supertramp - Feature #11872, Add example of icinga2 client recipe

- Thomas Supertramp - Feature #11959, Add example of icinga2 remote api listener recipe

- Thomas Supertramp - Bug #11769, Fix rubocop offenses

- Thomas Supertramp - Feature #11960, Allow to set a var as command_endpoint and not only string

- Henry Finucane - Add unit tests for formatting output

- Henry Finucane - Add function to format ruby data

- Vincent Van Driessche - Fix notification, applynotification template for times parameter

- Virender Khatri - Bug #10775, Add zone resource to icinga2_applydependency resource

- Virender Khatri - Feature #10900, fix to allow multiple environment resources for an environment

- Van Driessche Vincent - Feature #10831, Adds support to use "assign where" in usergroups

- Virender Khatri - Feature #10831, Adds support to use "ignore where" in usergroups

2.7.0
-----

- Virender Khatri - Feature #10642, bump icinga2 version to v2.4.0

- Virender Khatri - Bug #10756, point default[pnp4nagios][auth_file] to icinga htpasswd file

- Virender Khatri - Bug #10755, manage directory /usr/share/icinga/ssi

- Virender Khatri - Bug #10753, fix cloning resource attributes from prior resource (CHEF-3694)

- Virender Khatri - Feature #10107, added chefspec

2.6.9
-----

- analogrithems@gmail.com - Bug 10090, attribute command is optional for resource checkcommand

- Virender Khatri - Bug #10055, env_custom_vars key must be of type string

- Martin Stiborsky - Feature 10094, added suport for placing configuration into zones in zones.d

- Martin Stiborsky - Feature 10094, support for default configuration zone

- Jo Rhett - Bug 10176, Fixed icinga log issue

- Virender Khatri - Feature #10223, Major Cookbook Refactoring for LWRP Resources

- Virender Khatri - Bug #9900, icinga2 classic ui user creation doc and code out of sync

- Virender Khatri - Bug #10276, delete resource checkercomponent in favor feature checker

- Virender Khatri - Bug #10261, fixes resource envhostgroup and environment to support zone distributed deployments

- Virender Khatri - Feature #10279, remove :delayed from service notify

- Virender Khatri - Feature #10280, object GelfWriter configuration attributes are optional

- Virender Khatri - Feature #10281, object GraphiteWriter configuration attributes are optional

- Virender Khatri - Feature #10282, object IdoMySqlConnection configuration attributes are optional

- Virender Khatri - Feature #10283, object IdoPgSqlConnection configuration attributes are optional

- Virender Khatri - Feature #10285, map attribute source default value to :resource_name for resource script

- Virender Khatri - Feature #10286, set resource timeperiod attribute import default value to legacy-timeperiod

- Virender Khatri - Bug #10334 and Feature #10333, added new attribute env_skip_node_vars and fixed env_filter_node_vars

- Jo Rhett - Feature #10573, Add the ability to include multiple user defined directories.

- Jo Rhett - Bug #10564, Day names need to be quoted in timeperiod definitions

- Virender Khatri - Bug #10585, update cookbook for default['icinga2']['user_defined_objects_dir']

- Virender Khatri - Bug #10149, added capability to add node attributes to custom vars

- Virender Khatri - Bug #9842, add inet ip address custom vars

- Virender Khatri - Bug #10215, added MYSQL_HOME env variable during schema load

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
