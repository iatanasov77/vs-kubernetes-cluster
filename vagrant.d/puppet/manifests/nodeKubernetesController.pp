Exec {
    path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/', '/usr/local/bin', '/usr/local/sbin/' ]
}

node default
{
    include stdlib 
    
    $vsConfig       = parseyaml( $facts['vs_config'] )
    $gitCredentials = parsejson( $facts['git_credentials'] )
    
    class { '::vs_kubernetes':
        type                => 'controller',
        hosts               => $vsConfig['hosts'],
        dependencies        => $vsConfig['dependencies'],
        
        packages            => $vsConfig['packages'],
        gitUserName         => $vsConfig['git']['userName'],
        gitUserEmail        => $vsConfig['git']['userEmail'],
        gitCredentials      => $gitCredentials,
        
        pod_network_plugins => $vsConfig['pod_network_plugins'],
        container_runtime   => $facts['container_runtime'],
        
        subsystems          => $vsConfig['subsystems'],
        
        vstools             => $vsConfig['vstools'],
        frontendtools       => $vsConfig['frontendtools'],
        
        #############################################################################
        # LAMP SERVER
        #############################################################################
        forcePhp7Repo               => $vsConfig['lamp']['forcePhp7Repo'],
        mySqlProvider               => $vsConfig['lamp']['mysql']['provider'],
        phpVersion                  => "${vsConfig['lamp']['phpVersion']}",
        apacheModules               => $vsConfig['lamp']['apacheModules'],
        
        phpModules                  => $vsConfig['lamp']['phpModules'],
        phpunit                     => $vsConfig['lamp']['phpunit'],
        
        phpSettings                 => $vsConfig['lamp']['phpSettings'],
        
        phpMyAdmin                  => $vsConfig['lamp']['phpMyAdmin'],
    }

    # Config sudo users
    sudo::conf { "vagrant":
        ensure          => "present",
        content         => "vagrant ALL=(ALL) NOPASSWD: ALL",
        sudo_file_name  => "vagrant",
    }
}
