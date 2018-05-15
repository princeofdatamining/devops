# hbase on hdfs
# http://hbase.apache.org/book.html#hadoop
if [ x"" == x"$1" ]; then
  HADOOP_VER="2.8.3"
else
  HADOOP_VER="$1"
fi

wget http://www-us.apache.org/dist/hadoop/common/hadoop-$HADOOP_VER/hadoop-$HADOOP_VER.tar.gz
tar -zxf hadoop-$HADOOP_VER.tar.gz -C /usr/share/java/
rm -rf hadoop-$HADOOP_VER.tar.gz
#ln -s /usr/share/java/hadoop-$HADOOP_VER/bin/hadoop /usr/local/bin/
#ln -s /usr/share/java/hadoop-$HADOOP_VER/bin/hdfs /usr/local/bin/
#ln -s /usr/share/java/hadoop-$HADOOP_VER/bin/mapred /usr/local/bin/
#ln -s /usr/share/java/hadoop-$HADOOP_VER/bin/yarn /usr/local/bin/
