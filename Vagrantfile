Vagrant::Config.run do |config|

	config.vm.box = 'precise64'
	config.vm.host_name = 'rails-box'
	config.vm.forward_port 3000, 3000

	config.vm.provision :puppet do |puppet|
		puppet.manifests_path = "puppet/manifests"
		puppet.module_path    = "puppet/modules"
		puppet.manifest_file  = "development.pp"
	end
end




