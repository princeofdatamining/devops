MAJOR_VERSION=9
VERSION=9.0.7
wget https://mirrors.aliyun.com/apache/tomcat/tomcat-$MAJOR_VERSION/v$VERSION/bin/apache-tomcat-$VERSION.tar.gz
tar -xzf apache-tomcat-$VERSION.tar.gz -C /usr/share/java/
rm apache-tomcat-$VERSION.tar.gz
/usr/share/java/apache-tomcat-$VERSION/bin/startup.sh
