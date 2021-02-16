# vra_puppet_plugin_prep
#
# A description of what this class does
#
# @summary Prepares a PE master for vRA Puppet Plugin integration.
#
# @example
#   include vra_puppet_plugin_prep
#
# @example
#   class { 'vra_puppet_plugin_prep':
#     vro_plugin_user    => 'vro-plugin-user',
#     vro_password       => 'puppetlabs',
#     vro_password_hash  => '$1$Fq9vkV1h$4oMRtIjjjAhi6XQVSH6.Y.',
#     manage_autosign    => true,
#     autosign_secret    => 'S3cr3tP@ssw0rd!',
#   }
class vra_puppet_plugin_prep (
  String  $vro_plugin_user,
  Boolean $manage_localuser,
  Boolean $manage_sshd,
) {

  if $manage_localuser {
    user { $vro_plugin_user:
      ensure     => present,
      shell      => '/bin/bash',
      password   => $vro_password_hash,
      managehome => true,
    }
  }

  file { '/etc/sudoers.d/vro-plugin-user':
    ensure  => file,
    mode    => '0440',
    owner   => 'root',
    group   => 'root',
    content => epp('vra_puppet_plugin_prep/vro_sudoer_file.epp', { 'vro_plugin_user' => $vro_plugin_user }),
  }

  if $manage_sshd {
    sshd_config { 'PasswordAuthentication':
      ensure => present,
      value  => 'yes',
    }

    sshd_config { 'ChallengeResponseAuthentication':
      ensure => present,
      value  => 'no',
    }
  }

  package { 'rgen':
    ensure   => present,
    provider => puppet_gem,
  }

  package { 'puppet-strings':
    ensure   => present,
    provider => puppet_gem,
  }
}

