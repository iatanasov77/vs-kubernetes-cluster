Exec {
    path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/', '/usr/local/bin', '/usr/local/sbin/' ]
}

node default
{
    include stdlib 
    
    $vsConfig       = parseyaml( $facts['vs_config'] )
    $gitCredentials = parsejson( $facts['git_credentials'] )
    
    class { '::vs_kubernetes':
        type                => 'worker',
        hosts               => $vsConfig['hosts'],
        dependencies        => $vsConfig['dependencies'],
        
        packages            => $vsConfig['packages'],
        gitUserName         => $vsConfig['git']['userName'],
        gitUserEmail        => $vsConfig['git']['userEmail'],
        gitCredentials      => $gitCredentials,
        
        kubernetesConfig    => $vsConfig['kubernetes'],
        container_runtime   => $facts['container_runtime'],
        
        subsystems          => $vsConfig['subsystems'],
    }

    class { '::vs_kubernetes::subsystems::nfs_client':

    }

    # Config sudo users
    sudo::conf { "vagrant":
        ensure          => "present",
        content         => "vagrant ALL=(ALL) NOPASSWD: ALL",
        sudo_file_name  => "vagrant",
    }
}
