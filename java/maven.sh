if [ x"" == x"$1" ]; then
  VERSION="3.5.3"
else
  VERSION="$1"
fi

MAJOR_VERSION=${VERSION:0:1}

wget http://www-us.apache.org/dist/maven/maven-$MAJOR_VERSION/$VERSION/binaries/apache-maven-$VERSION-bin.tar.gz
tar -xzf apache-maven-$VERSION-bin.tar.gz -C /usr/share/java/
rm -rf apache-maven-$VERSION-bin.tar.gz
ln -s /usr/share/java/apache-maven-$VERSION/bin/mvn /usr/local/bin/
