# == Class: motd
#
# Full description of class motd here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'motd':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class motd {

  $motd_group = $::operatingsystem ? {
    solaris => 'sys',
    default => 'root',
  }

  $ascii_banner = generate('/usr/bin/env', '/usr/bin/figlet','-w', '186', '-p', '-f', 'slant', $::hostname)

  file { '/etc/motd':
    ensure  => file,
    content => template("${module_name}/motd.erb"),
    owner   => 'root',
    group   => $motd_group,
    mode    => '0644',
    backup  => false,
  }

}
