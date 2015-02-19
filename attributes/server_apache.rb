
default['icinga2']['apache_modules'] = value_for_platform(
  %w(centos redhat fedora) => { '7' => %w(default mod_wsgi mod_php5 mod_cgi mod_ssl mod_rewrite),
                                'default' => %w(default mod_python mod_php5 mod_cgi mod_ssl mod_rewrite) },
  'amazon' => { 'default' => %w(default mod_python mod_php5 mod_cgi mod_ssl mod_rewrite) },
  'ubuntu' => { 'default' => %w(default mod_python mod_php5 mod_cgi mod_ssl mod_rewrite) }
)
