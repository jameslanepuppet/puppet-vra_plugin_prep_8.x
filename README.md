
# vra_puppet_plugin_prep_8.x

Prepares a Puppet Enterprise master for vRA Puppet Plugin integration 8.x and above.

#### Table of Contents

1. [Description](#description)
2. [Beginning with vra_puppet_plugin_prep](#beginning-with-vra_puppet_plugin_prep)
3. [Usage](#usage)
4. [Reference](#reference)
6. [Contributors](#contributors)

## Description

When setting up the vRA Puppet Plugin there are some setup steps that need to be performed on the Puppet Enterprise Master. This module automates many of these, ie it ensures that:

- a system user exists for the plugin to ssh in with
- an api user exists for the plugin to utilise
- sudo rules are in place for this user so the plugin can run the commands it needs to
- autosign policy is configured (shared secret via challengePassword in the CSR)


## Beginning with vra_puppet_plugin_prep

Default behaviour (including autosign configuration enabled):

```
include vra_puppet_plugin_prep
```

## Usage

```puppet
class { 'vra_puppet_plugin_prep':
  vro_plugin_user   => 'vro-plugin-user'
  manage_localuser  => true,
}
```

## Reference

### Class: vra_puppet_plugin_prep

Parameters:

`vro_plugin_user`
The username the plugin will connect to Puppet with, both via ssh, and api

Default: `vro-plugin-user`
`system_uid`
Whether to create the vro plugin user as a system user.

Default: `false`


`manage_localuser`
Whether to configure the local user creation with this module

Default: True


## Contributors

Thank you to Jeremy Adams and other contributors to the [vRO Starter Content](https://github.com/puppetlabs/puppet-vro-starter_content) project, from which much of the code in this repo has been stolen.
