# steamcmd::install
#
# @summary Installs steamcmd
#
# @api private
#
class steamcmd::install inherits steamcmd {
  file { $steamcmd::installdir:
    ensure  => directory,
    owner   => $steamcmd::user,
    group   => $steamcmd::group,
    mode    => $steamcmd::file_mode,
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
    user         => $steamcmd::user,
    group        => $steamcmd::group,
    require      => User[$steamcmd::user],
  }

  exec { 'initialize':
    command => "${steamcmd::installdir}/${steamcmd::exe_name} +login anonymous +quit",
    cwd     => $steamcmd::installdir,
    user    => $steamcmd::user,
    creates => "${steamcmd::installdir}/public",
    returns => $steamcmd::exit_codes,
  }
}
