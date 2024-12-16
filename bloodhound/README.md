## Install Bloodhound server on Debian\Ubuntu latest
### Installare Node.js
     curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
     sudo apt install -y nodejs
Verify the installation

    node -v && npm -v
###  Install Neo4j
    wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/neo4j.gpg
    echo "deb [signed-by=/usr/share/keyrings/neo4j.gpg] https://debian.neo4j.com stable latest" | sudo tee /etc/apt/sources.list.d/neo4j.list
    sudo apt update
    sudo apt install -y neo4j


### Run Neo4j (and verify)
    sudo systemctl start neo4j
    sudo systemctl status neo4j
Change the default password for user neo4j:neo4j at http://127.0.0.1:7474

### Install Bloodhound (requires GTK UI)
Download the latest version at https://github.com/SpecterOps/BloodHound-Legacy/releases

Unzip the file:

    unzip BloodHound-linux-x64.zip
then enter the unzipped folder and run it:
    
    sudo ./BloodHound --no-sandbox
    
Use the neo4j password to login

## NetExec Bloodhound remote collector

### Install NetExec
    sudo apt install pipx git  python3-dev
    pipx install git+https://github.com/Pennyw0rth/NetExec
    pipx ensurepath

Restart your shell

### Run
    nxc ldap DC-IP -u domain_username  -p "Your password" -d yourdomain.local --dns-server DNS-IP --bloodhound --collection All
