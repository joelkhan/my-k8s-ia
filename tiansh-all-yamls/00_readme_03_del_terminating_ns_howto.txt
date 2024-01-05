如何删除一个Terminating状态的ns，参考：
https://blog.csdn.net/qq_31152023/article/details/107056559
https://juejin.cn/post/7210020384044335165
（1）kubectl get namespace dubhe-system -o json > devtesting.json
（2）编辑devtesting.json，删除字段spec.finalizers包含的内容，编辑后如下：
"spec": {
    "finalizers": [
     ]
},
（3）启动代理：
kubectl proxy --port=8080
测试：
curl http://localhost:8080/api/
（4）执行：
curl -k -H "Content-Type: application/json" -X PUT --data-binary @devtesting.json http://127.0.0.1:8080/api/v1/namespaces/dubhe-system/finalize

