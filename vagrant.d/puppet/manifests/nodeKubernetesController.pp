Exec {
    path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/', '/usr/local/bin', '/usr/local/sbin/' ]
}

node default
{
    $vsConfig = parseyaml( $facts['vs_config'] )
    
    class { '::vs_kubernetes':
        type                => 'controller',
        hosts               => $vsConfig['hosts'],
        
        gitUserName         => $vsConfig['git']['userName'],
        gitUserEmail        => $vsConfig['git']['userEmail'],
        gitCredentials      => $facts['git_credentials'],
        
        packages            => $vsConfig['packages'],
        vstools             => $vsConfig['vstools'],
        
        pod_network_plugins => $vsConfig['pod_network_plugins'],
        subsystems          => $vsConfig['subsystems'],
    }

    # Config sudo users
    sudo::conf { "vagrant":
        ensure          => "present",
        content         => "vagrant ALL=(ALL) NOPASSWD: ALL",
        sudo_file_name  => "vagrant",
    }
}
