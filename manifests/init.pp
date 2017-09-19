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
  Array[String] $required_packages
) {

  contain steamcmd::install

}
