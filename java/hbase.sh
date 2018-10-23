# hbase + hdfs
# http://hbase.apache.org/book.html#hadoop
if [ x"" == x"$1" ]; then
  HBASE_VER="2.0.0"
else
  HBASE_VER="$1"
fi

wget http://www-us.apache.org/dist/hbase/$HBASE_VER/hbase-$HBASE_VER-bin.tar.gz
tar -zxf hbase-$HBASE_VER-bin.tar.gz -C /usr/share/java/
rm -rf hbase-$HBASE_VER-bin.tar.gz
#ln -s /usr/share/java/hbase-$HBASE_VER/bin/hbase /usr/local/bin/
