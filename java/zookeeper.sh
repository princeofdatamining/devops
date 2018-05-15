if [ x"" == x"$1" ]; then
  ZOOKEEPER_VER="3.4.12"
else
  ZOOKEEPER_VER="$1"
fi

wget http://www-us.apache.org/dist/zookeeper/zookeeper-$ZOOKEEPER_VER/zookeeper-$ZOOKEEPER_VER.tar.gz
tar -zxf zookeeper-$ZOOKEEPER_VER.tar.gz -C /usr/share/java/
rm -rf zookeeper-$ZOOKEEPER_VER.tar.gz
# ln -s /usr/share/java/zookeeper-$ZOOKEEPER_VER/bin/
