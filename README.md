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
## Access Jenkins User Interface
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

# Installing Certbot
The first step to using Let’s Encrypt to obtain an SSL certificate is to install the Certbot software on your server.

Run from shell prompt
```
sudo apt install certbot python3-certbot-nginx
```
Confirming Nginx’s Configuration
Certbot needs to be able to find the correct server block in your Nginx configuration for it to be able to automatically configure SSL. Specifically, it does this by looking for a server_name directive that matches the domain you request a certificate for.

Run from shell prompt (replace domain)
```
sudo vi /etc/nginx/sites-available/jenkins.moncorp.uk
```
Find the existing server_name line. It should look like this:
Look for your domain
```
...
server_name jenkins.moncorp.uk;
...
```
If it does, exit your editor and move on to the next step. If not review the installing Nginx Tutorial
Obtaining an SSL Certificate¶
Certbot provides a variety of ways to obtain SSL certificates through plugins. The Nginx plugin will take care of reconfiguring Nginx and reloading the config whenever necessary. To use this plugin, type the following:

Run from shell prompt (replace domain)
```
sudo certbot --nginx -d jenkins.moncorp.uk
```
If that’s successful, certbot will ask how you’d like to configure your HTTPS settings.
Select your choice then hit ENTER. The configuration will be updated, and Nginx will reload to pick up the new settings. certbot will wrap up with a message telling you the process was successful and where your certificates are stored:

Verifying Certbot Auto-Renewal
Let’s Encrypt’s certificates are only valid for ninety days. This is to encourage users to automate their certificate renewal process. The certbot package we installed takes care of this for us by adding a systemd timer that will run twice a day and automatically renew any certificate that’s within thirty days of expiration.

You can query the status of the timer with systemctl:

Run from shell prompt
```
sudo systemctl status certbot.timer
```
Output should look like the below

Output
```
● certbot.timer - Run certbot twice daily
     Loaded: loaded (/lib/systemd/system/certbot.timer; enabled; vendor preset: enabled)
     Active: active (waiting) since Mon 2020-05-04 20:04:36 UTC; 2 weeks 1 days ago
    Trigger: Thu 2020-05-21 05:22:32 UTC; 9h left
   Triggers: ● certbot.service
```
To test the renewal process, you can do a dry run with certbot:
Run from shell prompt
```
sudo certbot renew --dry-run
```
If you see no errors, you’re all set. When necessary, Certbot will renew your certificates and reload Nginx to pick up the changes. If the automated renewal process ever fails, Let’s Encrypt will send a message to the email you specified, warning you when your certificate is about to expire.
Nginx should now be serving your domain name. You can test this by navigating to https://your_domain
