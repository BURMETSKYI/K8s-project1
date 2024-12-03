# Kubernetes CI/CD Pipeline Using Jenkins | DevOps Tutorial/Project - 2023

https://docs.dman.cloud/tutorial-documentation/install-jenkins/
https://github.com/dmancloud/complete-prodcution-e2e-pipeline

## Jenkins Installation¶
### Prerequsites

Virtual Machine running Ubuntu 22.04 or newer

Update Package Repository and Upgrade Packages
Become root
```
sudo -i
```
Run from shell prompt
```
sudo apt update
sudo apt upgrade
```
## Adoptium Java 17

### Add Adoptium repository
```
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
```
## Install Java 17
### Update repository and install Java
```
apt update
apt install temurin-17-jdk
/usr/bin/java --version
exit
```
## Install Jenkins
### First, add the repository key to the system:

Run from shell prompt
```
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
```
## Starting Jenkins
### Let’s start Jenkins by using systemctl:

Run from shell prompt
```
sudo systemctl start jenkins
```
Since systemctl doesn’t display status output, we’ll use the status command to verify that Jenkins started successfully:
Run from shell prompt
```
sudo systemctl status jenkins
```
If everything went well, the beginning of the status output shows that the service is active and configured to start at boot:
Run from shell prompt

Output
```
● jenkins.service - LSB: Start Jenkins at boot time
   Loaded: loaded (/etc/init.d/jenkins; generated)
   Active: active (exited) since Fri 2020-06-05 21:21:46 UTC; 45s ago
     Docs: man:systemd-sysv-generator(8)
    Tasks: 0 (limit: 1137)
   CGroup: /system.slice/jenkins.service
```
## Access Jenkins User Interface¶
To set up your installation, visit Jenkins on its default port, 8080, using your server domain name or IP address: http://your_server_ip_or_domain:8080

## Example Pipeline
You should receive the Unlock Jenkins screen, which displays the location of the initial password:

Sample Jenkinsfile
```
pipeline {
    agent any
    stages {
        stage('Hello World') {
            steps {
                echo 'Hello World'
            }
        }
    }
}
```
