# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   steamcmd::game { 'namevar': }
define steamcmd::game(
  Integer $game_id,
) {

  exec { 'install':
    command => "${steamcmd::installdir}/${steamcmd::exe_name} +login anonymous \
+force_install_dir '${steamcmd::installdir}/${title}' +app_update ${game_id} +quit",
    user    => $steamcmd::user,
    group   => $steamcmd::group,
  }
}
