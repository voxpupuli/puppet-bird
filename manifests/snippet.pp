#
# @summary manage a partial bird config file
#   on setups with many peers it's common to save each peer in a single file.
#   This is possible with this defined resource. Your bird config needs to contain an include statement!
#
# @param manage_v6 for bird1, there is a dedicated instance for IPv6. if this boolean is true, the config will be used for that instance
# @param validate if the new file should be validated. Beware: For some statements it's not possible to modify and validate them, in those cases you need to disable the check
# @param content The content of the snippet. You cannot provide this in combination with $source.
# @param source the source of the snippet. You cannot provide this in combination with $content.
#
# @example
#   bird::snippet { 'AS4242420181':
#    content => "protocol bgp AS4242420181 from dnpeers {\n  neighbor fe80::181:1%as20181 as 4242420181;\n}\n",
#   }
#
# @author Tim Meusel <tim@bastelfreak.de>
#
define bird::snippet (
  Boolean $manage_v6 = false,
  Boolean $validate = true,
  Optional[Variant[String[1], Sensitive[String[1]]]] $content = undef,
  Optional[Stdlib::Filesource] $source = undef,
) {
  include bird
  if $content =~ NotUndef and $source =~ NotUndef {
    fail('you can only set $content or $source')
  }
  if $content =~ Undef and $source =~ Undef {
    fail('you need to set $content or $source')
  }
  if $manage_v6 {
    $additional_config_path = $bird::additional_config_path_v6
    $validate_cmd = "${bird::v6_path} -p -c ${bird::config_path_v6}"
    $require_filepath = File[$bird::config_path_v6]
    $daemon_name = Service[$bird::daemon_name_v6]
  } else {
    $additional_config_path = $bird::additional_config_path_v4
    $validate_cmd = "${bird::v4_path} -p -c ${bird::config_path_v4}"
    $require_filepath = File[$bird::config_path_v4]
    $daemon_name = Service[$bird::daemon_name_v4]
  }
  $filepath = "${additional_config_path}/${title}"
  # we cannot validate the snippets, only the whole config
  # the main config file includes the snippets, hence we validate the main config for each snippet
  # because of that, the snippets require the main file
  if $validate {
    $_validate_cmd = $validate_cmd
  } else {
    $_validate_cmd  = undef
  }
  file { $filepath:
    ensure       => 'file',
    source       => $source,
    content      => $content,
    owner        => 'root',
    group        => 'root',
    mode         => '0644',
    validate_cmd => $_validate_cmd,
    require      => $require_filepath,
  }
  if $bird::manage_service {
    File[$filepath] ~> $daemon_name
  }
}
