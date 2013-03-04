# http://phaseshiftllc.com/articles/2012/03/19/setting-up-vagrant-with-rvm-and-mysql-for-rails-development.html

#The puppet-rvm package uses Puppet run stages to set itself as the first
# package to run. We need to run apt-get update and install our packages before
# this happens. So, we are creating our own run stage, and running ours before
# puppet-rvm's.
stage { 'req-install': before => Stage['rvm-install'] }



# This is where we define the packages we need to install. You can see we
# define a list of packages, including mysql-client, and we require that
# apt-get update is run before installation. Also, we're ensuring that a group
# puppet is present on the system. If you need other packages, just add them to
# the list.
class requirements {
  group { "puppet": ensure => "present", }
  exec { "apt-update":
    command => "/usr/bin/apt-get -y update"
  }

  package {
    ["mysql-client", "mysql-server", "libmysqlclient-dev"]:
      ensure => installed, require => Exec['apt-update']
  }
}

# Here, we are installing RVM as a system install, but are not setting it as
# the system default. Vagrant has a "system" ruby installed by default, and we
# want to make sure this remains the default. We are also adding the vagrant
# user as an RVM system user to avoid needing rvm-sudo when running ruby
# executables.
class installrvm {
  include rvm
  rvm::system_user { vagrant: ; }

  if $rvm_installed == "true" {
    rvm_system_ruby {
      'ruby-1.9.3-p0':
        ensure => 'present';
    }
  }
}

# Finally, we hook our requirements setup into our custom Puppet run stage and
# install both the requirements and RVM setups we defined. The final line runs
# our setup.
class doinstall {
  class { requirements:, stage => "req-install" }
  include installrvm
}

include doinstall