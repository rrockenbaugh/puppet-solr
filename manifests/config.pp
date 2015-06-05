# == Class solr::config
#
# This class is called from solr for service config.
#
class solr::config {
  file { "/var/solr/solr.in.sh":
    ensure  => file,
    mode    => '0755',
    owner   => "solr",
    group   => "solr",
    content => template('solr/solr.in.sh.erb'),
  }
  file { "/opt/solr-5.1.0/server/resources/log4j.properties":
    ensure  => file,
    mode    => '0644',
    owner   => "solr",
    group   => "solr",
    content => template('solr/log4j.properties.erb'),
  }
  file { "/var/solr/log4j.properties":
    ensure  => file,
    mode    => '0644',
    owner   => "solr",
    group   => "solr",
    content => template('solr/log4j.properties.erb'),
  }
  file { "/etc/init.d/solr":
    ensure  => file,
    mode    => '0744',
    content => template('solr/solr.init.erb'),
  }
}
