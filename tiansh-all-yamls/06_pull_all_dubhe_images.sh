# 服务镜像：
sudo docker pull registry.cn-hangzhou.aliyuncs.com/enlin/imgprocess:v1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/enlin/ofrecord:v1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/enlin/videosample:v1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/enlin/dubhe-java:v1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/enlin/visual-server:v1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/enlin/model-converter:v1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/enlin/model-measuring:v1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/enlin/oneflow-gpu:base
sudo docker pull registry.cn-hangzhou.aliyuncs.com/enlin/automl-nas-pytorch17:v1
sudo docker pull minio/minio:RELEASE.2020-04-28T23-56-56Z
sudo docker pull nacos/nacos-mysql:5.7
sudo docker pull nacos/nacos-server:2.0.3
sudo docker pull redis:5.0.7
sudo docker pull registry.cn-hangzhou.aliyuncs.com/enlin/storage-init:v1

# 业务镜像：
#  天枢安装脚本以及所需镜像、数据集上传工具、可视化服务等文件
sudo docker pull registry.cn-hangzhou.aliyuncs.com/kesu/data-download:v1
#  天枢预置数据集
sudo docker pull registry.cn-hangzhou.aliyuncs.com/kesu/data-dataset:v1
#  炼知模型
sudo docker pull registry.cn-hangzhou.aliyuncs.com/kesu/data-model-lianzhi:v1
#  算法镜像
sudo docker pull registry.cn-hangzhou.aliyuncs.com/dubhe-tianshu/algorithm:v1 && sudo docker tag registry.cn-hangzhou.aliyuncs.com/dubhe-tianshu/algorithm:v1 algorithm:v1
#  serving镜像
sudo docker pull registry.cn-hangzhou.aliyuncs.com/dubhe-tianshu/serving-gpu:base && sudo docker tag registry.cn-hangzhou.aliyuncs.com/dubhe-tianshu/serving-gpu:base  harbor.dubhe.com/train/serving-gpu:base 
#  notebook镜像
sudo docker pull registry.cn-hangzhou.aliyuncs.com/enlin/notebook:v1
#  pytorch-demo镜像
sudo docker pull registry.cn-hangzhou.aliyuncs.com/dubhe-tianshu/pytorch-demo:v1  


