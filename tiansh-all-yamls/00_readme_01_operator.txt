（0）【在k8fri上】
下载一个redis-6.0.8.tar.gz（“http://download.redis.io/releases/”），保存在/root/tools中
    （A）cd /root/tools 解压redis-6.0.8.tar.gz
	（B）临时升级gcc到版本7，否则后续编译报错
	    yum install centos-release-scl
		yum install devtoolset-7-gcc*
		scl enable devtoolset-7 bash
	（C）cd /root/tools/redis-6.0.8 执行：
	    make MALLOC=libc
	（D）cd src 可以看到“redis-cli”了
	后面的第（5）步启动一个pod，在pod运行的java程序会发起redis连接，
	可以使用这个redis-cli提前测试下连接的有效性。
	（E）cp /root/tools/redis-6.0.8/redis.conf 到 /opt/mycontainer-myredis-operator/etc/redis.conf 备用


（1）【在k8fri上】
配置java编译环境
检查java版本，执行：
java -version
检查javac版本，执行：
javac -version
如果没有javac，安装：
yum install java-devel
下载maven3.8
wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz
安装maven后，执行：
mvn -version
如果输出正常，则可以开始编译java工程


（2）【在k8fri上】
使用git下载天枢工程源码并编译，步骤如下：
git clone https://gitee.com/zhijiangtianshu/Dubhe.git
cd Dubhe/distribute-train-operator/
mvn clean compile package
（3）构建镜像
    （A）cd target/
    （B）创建Dockerfile文件
        cat > Dockerfile <<EOF
        FROM java:8
        ADD distribute-train-operator-1.0.jar /
        CMD ["bash", "-c", "exec java -jar \$JAR_BALL"]
        EOF
    （C）构建镜像
    docker build -t <your-harbor-url>/distribute-train/distribute-train-operator:v1 .
    （D）使用docker push推送镜像到Harbor


（4）在k8fri上启动一个为“distribute-train-operator”服务的redis
docker pull redis:6.0.8
docker run -p 46379:6379 --name myredis-operator -v /opt/mycontainer-myredis-operator/etc/redis.conf:/etc/redis/redis.conf -v /opt/mycontainer-myredis-operator/data:/data -d redis:6.0.8 redis-server /etc/redis/redis.conf --appendonly yes

