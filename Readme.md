BitPivot-Web
============

BitPivot web site and associated web apps.  Confedential.



Development with Vagrant VM and Rails
-------------------------------------

Development with Vagrant requires local installations of Ruby, Virtual Box, and Vagrant.

* [Install Ruby](http://www.ruby-lang.org/e/)
* [Install Virtual Box and Vagrant](http://www.vagrantup.com)
* `cd` into the project directory
* Run `git submodule foreach git pull origin master` to ensure that all submodules are up to date.
* Ensure that you have working symlinks for the Rails-Dev-Box submodule:
	* `Vagrantfile` should link to `rails-dev-box/Vagrantfile`
	* `puppet` should link to `rails-dev-box/puppet/`
* Run `vagrant up` to install and build the VM
* Wait
* Once the VM has finished building, run `vagrant status` to check that it is running
* Run `vagrant ssh` to remote into the VM
* Once remoted in:
	* Install Rails (`gem install rails`)
	* Change to the shared Vagrant folder (`cd /vagrant`)
	* Install project gems (`bundle install`)
	* Start the Rails test server (`rails server`)
	
From this point on, the server can be suspended and restarted whenever needed.  Af the initial setup, the only step that has to be repeated on reboot is starting the rails test server.