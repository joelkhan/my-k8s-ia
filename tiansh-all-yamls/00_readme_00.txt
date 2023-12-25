在集群环境下部署天枢平台的简要说明（3台集群+1台服务）
更详细说明请参考：https://docs.tianshu.org.cn/docs/setup/onekey-deploy-guide-cluster


/* *****
 *  00. 说明
 * ***** */
下文中的“跳过”，意指我在按照上述“参考”进行部署的过程中可以顺利完成。祝你也同样顺利。


/* *****
 *  01. 环境检查和安装（跳过）
 * ***** */
我已经准备了4台PVE虚机，本步骤中涉及到的：
（1）ssh，已安装
（2）docker，安装在k8fri上
（3）GPU，因宿主机上已没有显卡资源，跳过（即当前的节点运行时不具备GPU能力）
（4）需要提前拉取的镜像如下：
    （A）相关服务
    docker pull registry.cn-hangzhou.aliyuncs.com/enlin/imgprocess:v1
    docker pull registry.cn-hangzhou.aliyuncs.com/enlin/ofrecord:v1
    docker pull registry.cn-hangzhou.aliyuncs.com/enlin/videosample:v1
    docker pull registry.cn-hangzhou.aliyuncs.com/enlin/dubhe-java:v1
    docker pull registry.cn-hangzhou.aliyuncs.com/enlin/visual-server:v1
    docker pull registry.cn-hangzhou.aliyuncs.com/enlin/model-converter:v1
    docker pull registry.cn-hangzhou.aliyuncs.com/enlin/model-measuring:v1
    docker pull registry.cn-hangzhou.aliyuncs.com/enlin/oneflow-gpu:base
    docker pull registry.cn-hangzhou.aliyuncs.com/enlin/automl-nas-pytorch17:v1
    docker pull minio/minio:RELEASE.2020-04-28T23-56-56Z
    docker pull nacos/nacos-mysql:5.7
    docker pull nacos/nacos-server:2.0.3
    docker pull redis:5.0.7
    docker pull registry.cn-hangzhou.aliyuncs.com/enlin/storage-init:v1
    （B）相关业务
    #  天枢安装脚本以及所需镜像、数据集上传工具、可视化服务等文件
    docker pull registry.cn-hangzhou.aliyuncs.com/kesu/data-download:v1
    #  天枢预置数据集
    docker pull registry.cn-hangzhou.aliyuncs.com/kesu/data-dataset:v1
    #  炼知模型
    docker pull registry.cn-hangzhou.aliyuncs.com/kesu/data-model-lianzhi:v1
    #  算法镜像
    docker pull registry.cn-hangzhou.aliyuncs.com/dubhe-tianshu/algorithm:v1
    docker tag registry.cn-hangzhou.aliyuncs.com/dubhe-tianshu/algorithm:v1 algorithm:v1
    #  serving镜像
    docker pull registry.cn-hangzhou.aliyuncs.com/dubhe-tianshu/serving-gpu:base
    docker tag registry.cn-hangzhou.aliyuncs.com/dubhe-tianshu/serving-gpu:base  harbor.dubhe.com/train/serving-gpu:base 
    #  notebook镜像
    docker pull registry.cn-hangzhou.aliyuncs.com/enlin/notebook:v1
    #  pytorch-demo镜像
    docker pull registry.cn-hangzhou.aliyuncs.com/dubhe-tianshu/pytorch-demo:v1  
（5）Harbor，安装在k8fri上


/* *****
 *  02. 安装kubesphere
 * ***** */
（1）安装kubesphere集群，跳过
（2）在主节点部署k8s相关组件
    （A）01_ingress.yaml
		检查结果：
		kubectl get pod -n ingress-nginx
		kubectl get svc -n ingress-nginx
    （B）02_EFK.yaml
		检查结果，查看pod：
		kubectl get pod -n kube-system -o wide
		查看svc：
		kubectl get svc -n kube-system
		查看kibana的端口：
		kubectl get svc -A| grep kibana| awk '{print $6}'|awk -F ':|/' '{print $2}'
		访问kibana的web服务，完成配置：
		http://{masterip}:{上面返回的端口}/app/kibana#/dev_tools/console?_g=()
    （C）03_metrics_server.yaml
		检查结果：
		kubectl top node --use-protocol-buffers
    （D）04_monitor.yaml
		检查结果：
		kubectl get pods,svc -o wide -n tiansh-monitoring
	（E）05_distribute_train_operator.yaml
		这部分的readme，参见同目录下的“00_readme_01_operator.txt”
		kubectl get pod -n kube-system | grep distribute-train-operator
（3）部署GPU相关服务（没有GPU可忽略）


/* *****
 *  03. 部署天枢服务
 * ***** */


/* *****
 *  04. 安装部署NFS
 * ***** */


/* *****
 *  05. 服务验证
 * ***** */

