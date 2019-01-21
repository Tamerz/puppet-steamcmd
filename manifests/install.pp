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
    ensure  => directory,
    owner   => $steamcmd::user,
    group   => $steamcmd::group,
    mode    => '0755',
    require => User[$steamcmd::user],
  }

  package { $steamcmd::required_packages:
    ensure => installed,
  }

  if $steamcmd::user {
    user { $steamcmd::user:
      ensure => present,
      system => true,
      home   => $steamcmd::installdir,
    }
  }

  archive { 'installer':
    ensure       => present,
    path         => $steamcmd::archive_path,
    extract      => true,
    extract_path => $steamcmd::installdir,
    source       => $steamcmd::download_path,
    creates      => "${steamcmd::installdir}/${steamcmd::exe_name}",
    cleanup      => true,
  }

  exec { 'initialize':
    command => "${steamcmd::installdir}/${steamcmd::exe_name} +login anonymous +quit",
    cwd     => $steamcmd::installdir,
    user    => $steamcmd::user,
  }

}
