# steamcmd::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include steamcmd::install
class steamcmd::install inherits steamcmd {

  file { $installdir:
    ensure => directory,
  }

  package { $required_packages:
    ensure => installed,
  }

  if $user {
    user { $user:
      ensure => present,
    }
  }

  archive { 'installer':
    ensure       => present,
    path         => $archive_path,
    extract      => true,
    extract_path => $installdir,
    source       => $download_path,
    creates      => "${installdir}/steamcmd.exe",
    cleanup      => true,
  }

}
