# 这里，pv的名字是我在“06_dubhe_pv_all.yaml”中使用的
sudo kubectl delete pv dubhe-pv-dubhe-storage
sudo kubectl delete pv dubhe-pv-mysql
sudo kubectl delete pv dubhe-pv-nacos
sudo kubectl delete pv dubhe-pv-redis
sudo kubectl delete pv dubhe-pv-dcm4chee

# 说明：如果某个或某几个pv在删除时卡住，可以执行：
# kubectl patch pv dubhe-pv-dcm4chee dubhe-pv-mysql dubhe-pv-nacos -p '{"metadata":{"finalizers":null}}'
# 上面的命令直接删除了3个处于“Terminating”的PV
