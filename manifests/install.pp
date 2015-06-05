# == Class solr::install
#
# This class is called from solr for install.
#
class solr::install {

  ::staging::deploy { "solr-5.1.0.tgz":
    target => "/opt",
    source => "http://www.apache.org/dist/lucene/solr/5.1.0/solr-5.1.0.tgz",
  }
  user { "solr":
    ensure     => present,
    managehome => true,
    system     => true,
    before     => Exec['run solr install script'],
  }
  exec { 'run solr install script':
    command => "/opt/staging/solr-5.1.0/bin/install_solr_service.sh /opt/staging/solr-5.1.0.tgz -i /opt -d /var/solr -u solr -s solr -p 8983",
    cwd     => "/opt/staging/solr-5.1.0",
    creates => "/opt/solr-5.1.0",
    require => Staging::Deploy["solr-5.1.0.tgz"],
  }
  file { "/var/solr":
    ensure  => directory,
    owner   => "solr",
    group   => "solr",
    recurse => true,
    require => Exec['run solr install script'],
  }
  file { "/var/log/solr":
    ensure  => directory,
    owner   => "solr",
    group   => "solr",
    require => Exec['run solr install script'],
  }
}
