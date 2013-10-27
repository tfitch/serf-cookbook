# serf cookbook

Installs Serf (http://serfdom.io) app on a Linux machine.

Will *not* update an existing install to a newer version.  Still researching how to do that on a running environment.

Be default, the latest version will be pulled from http://downloads.serfdom.io/latest

Will *not* start up Serf for you after it is installed.  So far, this is just getting the installer scripted.

# Requirements
That you have unzip and curl or wget already installed on your machine

## Platform

* Supports 32-bit and 64-bit platforms of Linux
* Tested on CentOS 6.4 and Ubuntu 12.04
* Should work fine on Debian, RHEL, etc.

# Usage
Include the serf recipe to install serf on your system based on the default installation method:
* include_recipe "serf"

# Attributes
* serf['version'] - release version of serf to install, default is 'latest'

# TODO
* upgrading/installer newer version when app actively running?
* Windows, OSX and BSD support
* determine when ARM architecture

# Author

Author:: Tyler Fitch (<github@tfitch.com>)