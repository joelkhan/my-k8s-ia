（0）【在k8fri上】
下载一个redis-6.0.8.tar.gz（“http://download.redis.io/releases/”），保存在/root/tools中
    （A）cd /root/tools 解压redis-6.0.8.tar.gz
	（A.1）可能需要先安装Development Tools，执行：
		yum groupinstall "Development Tools"
	（B）临时升级gcc到版本7，否则后续编译报错
	    gcc -v （先查看下gcc的版本）
		yum install centos-release-scl
		yum install devtoolset-7-gcc*
		scl enable devtoolset-7 bash
	（C）cd /root/tools/redis-6.0.8 执行：
	    make MALLOC=libc
	（D）cd src 可以看到“redis-cli”了
		后面的第（5）步启动一个pod，在pod运行的java程序会发起redis连接，
		可以使用这个redis-cli提前测试下连接的有效性。
	（E）拷贝配置文件：
		cp /root/tools/redis-6.0.8/redis.conf 到 /root/my-config/distribute-train-operator/my-redis/redis.conf 
		编辑上述配置文件，
		vi /root/my-config/distribute-train-operator/my-redis/redis.conf
		参考：https://blog.csdn.net/qq_40313468/article/details/109249331


（1）【在k8fri上】
配置java编译环境
检查java版本，执行：
java -version
检查javac版本，执行：
javac -version
如果没有javac，安装：
yum install java-devel
部署maven3.8
	下载：  wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz
	解压：  tar -zxof ./apache-maven-3.8.8-bin.tar.gz
	移动：  mv apache-maven-3.8.8 /usr/local/
	软链接：ln -s /usr/local/apache-maven-3.8.8/ /usr/local/maven3
配置maven，执行：
	vi ~/.bash_profile
	export MAVEN_HOME=/usr/local/maven3
	PATH=$MAVEN_HOME/bin:$PATH
安装maven后，执行：
mvn -v
如果输出正常，则可以开始编译java工程


（2）【在k8fri上】
使用git下载天枢工程源码并编译，步骤如下：
git clone https://gitee.com/zhijiangtianshu/Dubhe.git
cd Dubhe/distribute-train-operator/
mvn clean compile package
（3）构建镜像
    （A）cd target/
	（B）编辑我的Dockerfile如下：
		FROM openjdk:8
        ADD distribute-train-operator-1.0.jar /
        CMD java -jar $JAR_BALL
    （B.1）官方的Dockerfile创建，如下（拉起pod时报错）：
        cat > Dockerfile <<EOF
        FROM java:8
        ADD distribute-train-operator-1.0.jar /
        CMD ["/bin/bash", "-c", "exec java -jar \$JAR_BALL"]
        EOF
    （C）构建镜像
		docker build -t k8fri.tianshdemo.org/distribute-train/distribute-train-operator:v1 .
    （D）使用docker push推送镜像到Harbor


（4）【在k8fri上】启动一个为“distribute-train-operator”服务的redis
	（A）docker pull redis:6.0.8
	（B）docker run -p 46379:6379 --name myredis-operator -v /root/my-config/distribute-train-operator/my-redis/redis.conf:/etc/redis/redis.conf -v /root/my-data/distribute-train-operator/my-redis/data:/data -d redis:6.0.8 redis-server /etc/redis/redis.conf --appendonly yes
	（C）使用步骤（0）的redis-cli测试，执行：
	cd /root/tools/redis-6.0.8/src
	./redis-cli -h 192.168.3.196 -p 46379


