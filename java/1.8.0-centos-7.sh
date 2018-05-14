yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel

# The JAVA_HOME variable should be set to a directory which contains the executable file bin/java.
#echo "export JAVA_HOME=/usr/lib/jvm/java" >> ~/.bash_profile

# Most modern Linux operating systems provide a mechanism, such as /usr/bin/alternatives on RHEL or CentOS, 
# for transparently switching between versions of executables such as Java. 
# In this case, you can set JAVA_HOME to the directory containing the symbolic link to bin/java, which is usually /usr.
echo "export JAVA_HOME=/usr" >> ~/.bash_profile
