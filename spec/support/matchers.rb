# frozen_string_literal: true
if defined?(ChefSpec)
  def create_icinga2_apilistener(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_apilistener, :create, name)
  end

  def delete_icinga2_apilistener(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_apilistener, :delete, name)
  end

  def create_icinga2_apiuser(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_apiuser, :create, name)
  end

  def delete_icinga2_apiuser(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_apiuser, :delete, name)
  end

  def create_icinga2_applydependency(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_applydependency, :create, name)
  end

  def delete_icinga2_applydependency(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_applydependency, :delete, name)
  end

  def create_icinga2_applynotification(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_applynotification, :create, name)
  end

  def delete_icinga2_applynotification(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_applynotification, :delete, name)
  end

  def create_icinga2_applyservice(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_applyservice, :create, name)
  end

  def delete_icinga2_applyservice(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_applyservice, :delete, name)
  end

  def create_icinga2_checkcommand(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_checkcommand, :create, name)
  end

  def delete_icinga2_checkcommand(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_checkcommand, :delete, name)
  end

  def create_icinga2_checkresultreader(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_checkresultreader, :create, name)
  end

  def delete_icinga2_checkresultreader(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_checkresultreader, :delete, name)
  end

  def create_icinga2_compatlogger(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_compatlogger, :create, name)
  end

  def delete_icinga2_compatlogger(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_compatlogger, :delete, name)
  end

  def create_icinga2_endpoint(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_endpoint, :create, name)
  end

  def delete_icinga2_endpoint(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_endpoint, :delete, name)
  end

  def create_icinga2_envhostgroup(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_envhostgroup, :create, name)
  end

  def delete_icinga2_envhostgroup(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_envhostgroup, :delete, name)
  end

  def create_icinga2_environment(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_environment, :create, name)
  end

  def delete_icinga2_environment(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_environment, :delete, name)
  end

  def create_icinga2_eventcommand(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_eventcommand, :create, name)
  end

  def delete_icinga2_eventcommand(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_eventcommand, :delete, name)
  end

  def create_icinga2_externalcommandlistener(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_externalcommandlistener, :create, name)
  end

  def delete_icinga2_externalcommandlistener(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_externalcommandlistener, :delete, name)
  end

  def create_icinga2_feature(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_feature, :create, name)
  end

  def delete_icinga2_feature(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_feature, :delete, name)
  end

  def create_icinga2_filelogger(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_filelogger, :create, name)
  end

  def delete_icinga2_filelogger(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_filelogger, :delete, name)
  end

  def create_icinga2_gelfwriter(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_gelfwriter, :create, name)
  end

  def delete_icinga2_gelfwriter(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_gelfwriter, :delete, name)
  end

  def create_icinga2_graphitewriter(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_graphitewriter, :create, name)
  end

  def delete_icinga2_graphitewriter(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_graphitewriter, :delete, name)
  end

  def create_icinga2_host(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_host, :create, name)
  end

  def delete_icinga2_host(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_host, :delete, name)
  end

  def create_icinga2_hostgroup(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_hostgroup, :create, name)
  end

  def delete_icinga2_hostgroup(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_hostgroup, :delete, name)
  end

  def create_icinga2_idomysqlconnection(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_idomysqlconnection, :create, name)
  end

  def delete_icinga2_idomysqlconnection(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_idomysqlconnection, :delete, name)
  end

  def create_icinga2_idopgsqlconnection(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_idopgsqlconnection, :create, name)
  end

  def delete_icinga2_idopgsqlconnection(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_idopgsqlconnection, :delete, name)
  end

  def create_icinga2_livestatuslistener(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_livestatuslistener, :create, name)
  end

  def delete_icinga2_livestatuslistener(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_livestatuslistener, :delete, name)
  end

  def create_icinga2_notification(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_notification, :create, name)
  end

  def delete_icinga2_notification(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_notification, :delete, name)
  end

  def create_icinga2_notificationcommand(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_notificationcommand, :create, name)
  end

  def delete_icinga2_notificationcommand(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_notificationcommand, :delete, name)
  end

  def create_icinga2_notificationcomponent(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_notificationcomponent, :create, name)
  end

  def delete_icinga2_notificationcomponent(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_notificationcomponent, :delete, name)
  end

  def create_icinga2_perfdatawriter(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_perfdatawriter, :create, name)
  end

  def delete_icinga2_perfdatawriter(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_perfdatawriter, :delete, name)
  end

  def create_icinga2_scheduleddowntime(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_scheduleddowntime, :create, name)
  end

  def delete_icinga2_scheduleddowntime(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_scheduleddowntime, :delete, name)
  end

  def create_icinga2_script(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_script, :create, name)
  end

  def delete_icinga2_script(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_script, :delete, name)
  end

  def create_icinga2_service(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_service, :create, name)
  end

  def delete_icinga2_service(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_service, :delete, name)
  end

  def create_icinga2_servicegroup(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_servicegroup, :create, name)
  end

  def delete_icinga2_servicegroup(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_servicegroup, :delete, name)
  end

  def create_icinga2_statusdatawriter(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_statusdatawriter, :create, name)
  end

  def delete_icinga2_statusdatawriter(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_statusdatawriter, :delete, name)
  end

  def create_icinga2_sysloglogger(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_sysloglogger, :create, name)
  end

  def delete_icinga2_sysloglogger(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_sysloglogger, :delete, name)
  end

  def create_icinga2_timeperiod(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_timeperiod, :create, name)
  end

  def delete_icinga2_timeperiod(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_timeperiod, :delete, name)
  end

  def create_icinga2_user(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_user, :create, name)
  end

  def delete_icinga2_user(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_user, :delete, name)
  end

  def create_icinga2_usergroup(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_usergroup, :create, name)
  end

  def delete_icinga2_usergroup(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_usergroup, :delete, name)
  end

  def create_icinga2_zone(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_zone, :create, name)
  end

  def delete_icinga2_zone(name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:icinga2_zone, :delete, name)
  end
end
