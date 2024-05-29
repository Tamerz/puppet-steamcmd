# steamcmd
#
# @summary Installs Valve Corporation's "Steam Console Client".
#
# @param installdir
#   Where to install steamcmd
#
# @param required_packages
#   Array of packages required
#
# @param download_path
#   Location of the steamcmd download
#
# @param archive_path
#
# @param exe_name
#
# @param exit_codes
#
# @param user
#
# @param group
#
# @param file_mode
#
# @example
#   include steamcmd
class steamcmd (
  String $installdir,
  Array[String] $required_packages,
  String $download_path,
  String $archive_path,
  String $exe_name,
  Array[Integer] $exit_codes,
  Optional[String] $user,
  Optional[String] $group,
  Optional[String] $file_mode,
) {
  contain steamcmd::install
}
