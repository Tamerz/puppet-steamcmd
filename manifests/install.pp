# steamcmd::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include steamcmd::install
class steamcmd::install inherits steamcmd {

  file { $steamcmd::installdir:
    ensure => directory,
  }

  package { $steamcmd::required_packages:
    ensure => installed,
  }

  if $steamcmd::user {
    user { $steamcmd::user:
      ensure => present,
    }
  }

  archive { 'installer':
    ensure       => present,
    path         => $steamcmd::archive_path,
    extract      => true,
    extract_path => $steamcmd::installdir,
    source       => $steamcmd::download_path,
    creates      => "${steamcmd::installdir}/steamcmd.exe",
    cleanup      => true,
  }

}
