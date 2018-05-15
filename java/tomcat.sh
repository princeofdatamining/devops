if [ x"" == x"$1" ]; then
  VERSION="9.0.7"
else
  VERSION="$1"
fi

MAJOR_VERSION=${VERSION:0:1}

wget https://mirrors.aliyun.com/apache/tomcat/tomcat-$MAJOR_VERSION/v$VERSION/bin/apache-tomcat-$VERSION.tar.gz
tar -xzf apache-tomcat-$VERSION.tar.gz -C /usr/share/java/
rm -rf apache-tomcat-$VERSION.tar.gz
/usr/share/java/apache-tomcat-$VERSION/bin/startup.sh
