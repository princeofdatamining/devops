
# https://jenkins.io/doc/book/installing/
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install -y jenkins
# sudo service jenkins start
sudo systemctl start jenkins
sudo chkconfig jenkins on
sudo systemctl status jenkins

# https://jenkins.io/doc/pipeline/tour/getting-started/
# $(cd /usr/share/java; wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war)
