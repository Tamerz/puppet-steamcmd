# steamcmd
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include steamcmd
class steamcmd (
  String $installdir,
  Array[String] $required_packages,
  String $download_path,
  String $archive_path,
  String $exe_name,
  Optional[String] $user,
  Optional[String] $group,
) {

  contain steamcmd::install

}
