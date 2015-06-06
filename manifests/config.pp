# == Class solr::config
#
# This class is called from solr for service config.
#
class solr::config {
  file { "${solr::var_dir}/solr.in.sh":
    ensure  => file,
    mode    => '0755',
    owner   => $solr::solr_user,
    group   => $solr::solr_user,
    content => template('solr/solr.in.sh.erb'),
  }
  file { "${solr::extract_dir}/solr-${solr::version}/server/resources/log4j.properties":
    ensure  => file,
    mode    => '0644',
    owner   => $solr::solr_user,
    group   => $solr::solr_user,
    content => template('solr/log4j.properties.erb'),
  }
  file { "${solr::var_dir}/log4j.properties":
    ensure  => file,
    mode    => '0644',
    owner   => $solr::solr_user,
    group   => $solr::solr_user,
    content => template('solr/log4j.properties.erb'),
  }
  file { "/etc/init.d/${solr::service_name}":
    ensure  => file,
    mode    => '0744',
    content => template('solr/solr.init.erb'),
  }
}
