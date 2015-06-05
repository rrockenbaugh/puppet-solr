# == Class solr::service
#
# This class is meant to be called from solr.
# It ensures the service is running.
#
class solr::service {

  service { $::solr::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
