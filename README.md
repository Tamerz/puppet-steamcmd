
# steamcmd [![Build Status](https://travis-ci.org/Tamerz/puppet-steamcmd.svg?branch=master)](https://travis-ci.org/Tamerz/puppet-steamcmd)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with steamcmd](#setup)
    * [Beginning with steamcmd](#beginning-with-steamcmd)
3. [Usage - Configuration options and additional functionality](#usage)

## Description

The steamcmd module installs Valve Corporation's "Steam Console Client".

steamcmd is used to host many different game servers based on Steam's platform.

## Setup

### Beginning with steamcmd

`include steamcmd` will install steamcmd in `/opt/steamcmd` for Linux and `C:\Steamcmd` for Windows.


## Usage

To customize the installation, the following parameters are available:

`installdir`: The location to install steamcmd to. Default on Linux is `/opt/steamcmd` and Windows is `C:\Steamcmd`

`user`: This will create a user that owns the directory. Default is `steamcmd`

`group`: This will create a group that owns the directory. Default is `steamcmd`

For instance, to install to a different location with different users and groups:

```puppet
class { 'steamcmd':
  installdir => '/home/steam',
  user       => 'steam',
  group      => 'steam',
}
```
