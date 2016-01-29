# == Class solr::install
#
# This class is called from solr for install.
#
class solr::install {

  staging::deploy { "solr-${solr::version}.tgz":
    target => '/opt/staging',
    source => "${solr::mirror}/${solr::version}/solr-${solr::version}.tgz",
    staging_path => "/opt/staging/solr-${solr::version}.tgz",
    creates => "/opt/staging/solr-${solr::version}",
  }
  user { "solr":
    ensure     => present,
    managehome => true,
    system     => true,
    before     => Exec['run solr install script'],
  }
  if $::solr::upgrade {
    $upgrade_flag = '-f'
  }
  else {
    $upgrade_flag = ''
  }
  exec { 'run solr install script':
    command => "/opt/staging/solr-${solr::version}/bin/install_solr_service.sh /opt/staging/solr-${solr::version}.tgz -i ${solr::extract_dir} -d ${solr::var_dir} -u ${solr::solr_user} -s ${solr::service_name} -p ${solr::solr_port} ${upgrade_flag}",
    cwd     => "/opt/staging/solr-${solr::version}",
    creates => "${solr::extract_dir}/solr-${solr::version}",
    require => Staging::Deploy["solr-${solr::version}.tgz"],
  }
  file { $solr::var_dir:
    ensure  => directory,
    owner   => $solr::solr_user,
    group   => $solr::solr_user,
    recurse => true,
    require => Exec['run solr install script'],
  }
  file { $solr::log_dir:
    ensure  => directory,
    owner   => $solr::solr_user,
    group   => $solr::solr_user,
    require => Exec['run solr install script'],
  }
}
