# -*- mode: ruby -*-
# vi: set ft=ruby :

def fail_with_message( msg )
    fail Vagrant::Errors::VagrantError.new, msg
end

if ! Vagrant.has_plugin? 'vagrant-env'
    fail_with_message "vagrant-env missing, please install the plugin with this command:
            vagrant plugin install vagrant-env"
end

# Check for required vagrant plugins
if ! Vagrant.has_plugin? 'vagrant-hostmanager'
    fail_with_message "vagrant-hostmanager missing, please install the plugin with this command:
        vagrant plugin install vagrant-hostmanager"
end

# RUN VAGRANT
Vagrant.configure("2") do |config|
    config.env.enable
    
    config.hostmanager.enabled              = true
    config.hostmanager.manage_host          = true
    config.hostmanager.manage_guest         = false
    config.hostmanager.ignore_private_ip    = false
    config.hostmanager.include_offline      = true
    config.hostmanager.aliases              = []
    
    config.hostmanager.aliases.push( "#{ENV['CONTROLLER_HOST_NAME']} www.#{ENV['CONTROLLER_HOST_NAME']} api.#{ENV['CONTROLLER_HOST_NAME']}" )
    
    $done = <<-SCRIPT
echo "####################################################################"
echo "# This Machine is DONE!!!"
echo "####################################################################"
    SCRIPT
    
    # kubectl -n kubernetes-dashboard describe services kubernetes-dashboard | grep NodePort | tail -n1 | cut -c 36- | cut -b -5
    $finish = <<-SCRIPT
echo "##########################################################################################################################################"
echo "#"
echo "# All finished successfull "
echo "# ======================== "
echo "#"
echo "# -----------------------------------------------------------------------------"
echo "#"
echo "# Now You Can Open GUI on: http://kube-controller.lh"
echo "#"
echo "# -----------------------------------------------------------------------------"
echo "#"
echo "##########################################################################################################################################"
    SCRIPT
    
    ####################################################################
    # /BEGIN Kubernetes Controller Host
    config.vm.define ENV['CONTROLLER_MASHINE_NAME'], primary: true do |kch|
        kch.vm.box              = ENV['VAGRANT_BOX']
        
        kch.vm.hostname         = ENV['CONTROLLER_HOST_NAME']
        kch.vm.box_check_update = true
        
        if Vagrant.has_plugin?( "vagrant-vbguest" ) then
            kch.vbguest.auto_update = false
        end
        
        kch.vm.network :private_network, ip: ENV['CONTROLLER_PRIVATE_IP']
        
        kch.vm.synced_folder "./", "/vagrant"
    
        kch.vm.provider "virtualbox" do |vb|
            vb.gui      = false
            vb.name     = ENV['CONTROLLER_MASHINE_NAME']
            
            vb.cpus 	= 2
            vb.memory   = ENV['CONTROLLER_MACHINES_MEMORY']
            
            vb.check_guest_additions = false
        end
        
        kch.vm.provision "shell", path: "vagrant.d/provision/main.sh", env: {}
        
        require 'yaml'
        vsConfig    = YAML.load_file( ENV['PROVISION_CONFIG'] )

        kch.vm.provision :puppet do |puppet|
            puppet.manifests_path 		= 'vagrant.d/puppet/manifests'
            puppet.module_path    		= 'vagrant.d/puppet/modules'
            puppet.options        		= ['--verbose', '--debug']
    		
    		puppet.hiera_config_path	= "vagrant.d/puppet/hiera/hiera.yaml"
            puppet.manifest_file  		= "nodeKubernetesController.pp"
            puppet.facter         		= {
                'vs_config'				=> vsConfig.to_yaml,
                
                'controller_address'    => ENV['CONTROLLER_PRIVATE_IP'],
                'kubernetes_version'    => ENV['KUBERNETES_VERSION'],
                'container_runtime'     => ENV['CONTAINER_RUNTIME'],
                'containerd_version'    => ENV['CONTAINERD_VERSION'],
                'dashboard_version'     => ENV['DASHBOARD_VERSION'],
                'network_provider'      => ENV['KUBERNETES_NETWORK_PROVIDER'],
                'network_cidr'          => ENV['KUBERNETES_NETWORK_CIDR'],
                
                'git_credentials'       => JSON.parse( ENV['GIT_CREDENTIALS'] ),
            }
        end

        kch.vm.provision "shell", inline: $done
    end
    # /END Kubernetes Controller Host
    ####################################################################

    ####################################################################
    # /BEGIN Kubernetes Worker Host
    config.vm.define ENV['WORKER_MASHINE_NAME'] do |kwh|
        kwh.vm.box              = ENV['VAGRANT_BOX']
        
        kwh.vm.hostname         = ENV['WORKER_HOST_NAME']
        kwh.vm.box_check_update = true
        
        if Vagrant.has_plugin?( "vagrant-vbguest" ) then
            kwh.vbguest.auto_update = false
        end
        
        kwh.vm.network :private_network, ip: ENV['WORKER_PRIVATE_IP']
        
        kwh.vm.synced_folder ".", "/vagrant"
        
        kwh.vm.provider "virtualbox" do |vb|
            vb.gui      = false
            vb.name     = ENV['WORKER_MASHINE_NAME']
            
            vb.cpus     = 2
            vb.memory   = ENV['WORKER_MACHINES_MEMORY']
            
            vb.check_guest_additions = false
        end
    
        kwh.vm.provision "shell", path: "vagrant.d/provision/main.sh", env: {}

        require 'yaml'
        vsConfig    = YAML.load_file( ENV['PROVISION_CONFIG'] )

        kwh.vm.provision :puppet do |puppet|
            puppet.manifests_path       = 'vagrant.d/puppet/manifests'
            puppet.module_path          = 'vagrant.d/puppet/modules'
            puppet.options              = ['--verbose', '--debug']
    
            puppet.hiera_config_path    = "vagrant.d/puppet/hiera/hiera.yaml"
            puppet.manifest_file        = "nodeKubernetesWorker.pp"
            puppet.facter               = {
                'vs_config'				=> vsConfig.to_yaml,
                
                'controller_address'    => ENV['CONTROLLER_PRIVATE_IP'],
                'kubernetes_version'    => ENV['KUBERNETES_VERSION'],
                'container_runtime'     => ENV['CONTAINER_RUNTIME'],
                'containerd_version'    => ENV['CONTAINERD_VERSION'],
                'dashboard_version'     => ENV['DASHBOARD_VERSION'],
                
                'git_credentials'       => JSON.parse( ENV['GIT_CREDENTIALS'] ),
            }
        end
    
        kwh.vm.provision "shell", inline: $finish, env: {"MYVAR" => "value"}
    end
    # /END Kubernetes Worker Host
    ###################################################################
    
end
