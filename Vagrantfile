Vagrant.configure("2") do |config|
 
	 # Number of nodes to provision
	 numNodes = 2
 
	 # IP Address Base for private network
	 ipAddrPrefix1 = "192.168.56.2"
	 ipAddrPrefix2 = "192.168.57.2"
 
	 # Define Number of RAM for each node
	 config.vm.provider "virtualbox" do |v|
		  v.customize ["modifyvm", :id, "--memory", 256]
	 end
 
	 # Download the initial box from this url
 
	 # Provision Config for each of the nodes
	 1.upto(numNodes) do |num|
		  nodeName = ("node" + num.to_s).to_sym
		  config.vm.define nodeName do |node|
				node.vm.host_name = nodeName
				node.vm.box = "mjrider/debian-7-puppet"
				node.vm.network :private_network, ip: ipAddrPrefix1 + num.to_s
				node.vm.network :private_network, ip: ipAddrPrefix2 + num.to_s
				node.vm.provider "virtualbox" do |v|
					 v.name = "Node " + num.to_s
				end
				node.vm.provision :puppet do |puppet|
					puppet.manifests_path = "manifests"
					puppet.module_path = "modules"
					puppet.manifest_file = "site.pp"
					puppet.options = "--verbose"
					puppet.options = '--hiera_config=/etc/hiera.yaml'
				end
		  end
	 end
 
end
