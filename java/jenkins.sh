
# https://jenkins.io/doc/pipeline/tour/getting-started/
$(cd /usr/share/java; wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war)

# cat <<EOF > /usr/lib/systemd/system/jenkins.service
# [Unit]
# Description=Jenkins
# After=syslog.target network.target

# [Service]
# Type=notify
# PIDFile=/var/run/jenkins.pid
# ExecStart=/usr/bin/java -jar /usr/share/java/jenkins.war --httpPort=8080

# [Install]
# WantedBy=multi-user.target
# EOF

# systemctl enable jenkins
# systemctl restart jenkins
# systemctl status jenkins
