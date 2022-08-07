Exec {
    path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/', '/usr/local/bin', '/usr/local/sbin/' ]
}

node default
{
    $vsConfig = parseyaml( $facts['vs_config'] )
    
    class { '::vs_kubernetes':
        type        => 'worker',
        hosts       => $vsConfig['hosts'],
        
        packages            => $vsConfig['packages'],
        gitUserName         => $vsConfig['git']['userName'],
        gitUserEmail        => $vsConfig['git']['userEmail'],
        gitCredentials      => $facts['git_credentials'],
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
