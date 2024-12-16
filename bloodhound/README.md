# NetExec Bloodhound remote collector

## Install NetExec
    sudo apt install pipx git  python3-dev
    pipx install git+https://github.com/Pennyw0rth/NetExec
    pipx ensurepath
    source .bashrc
## Run
    nxc ldap DC-IP -u domain_username  -p "Your password" -d yourdomain.local --dns-server DNS-IP --bloodhound --collection All
