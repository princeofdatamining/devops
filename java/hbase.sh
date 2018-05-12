HBASE_VER=2.0.0

wget http://www-us.apache.org/dist/hbase/$HBASE_VER/hbase-$HBASE_VER-bin.tar.gz
tar -zxf hbase-$HBASE_VER-bin.tar.gz -C /usr/share/java/
ln -s /usr/share/java/hbase-$HBASE_VER/bin/hbase /usr/local/bin/
rm -f hbase-$HBASE_VER-bin.tar.gz
