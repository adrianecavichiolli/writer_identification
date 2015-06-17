##基于ScatNet的中文手写体鉴别
##ScatNet-Based Writer Identification 



###数据集：
[下载地址](http://pan.baidu.com/s/1eQ8NfqE)  


###文件夹介绍  
#####传统特征提取方法
Contourlet： 轮廓波特征提取和分类     
DTCWT： 双树复小波特征提取与分类  
DWT： 离散小波特征提取与分类  
NACT： 抗混叠特征提取与分类  
NSCT： 剪切波特征提取与分类  
PDTDFB： 双树金字塔复小波特征提取与分类  
#####ScatNet相关方法
##
Scatter_xPCA： 散射特征结合PCA进行特征提取与分类  
 *除了使用PCA方法进行降维外，使用了LLE、LLP、LDA、KPCA等方法对特征系数完成降维。*
##
scatter\_copula\_gamma: 散射特征结合copula模型进行特征提取与分类   
ScatterFast: 散射特征结合拟合公式快速进行特征提取与分类  



####实验步骤及总结  
进入到各个文件夹运行main.m文件  
[阶段实验总结](https://github.com/matrixorz/writer_identification/blob/master/%E5%AE%9E%E9%AA%8C%E6%80%BB%E7%BB%9310_31.docx)  


###致谢
本程序基于[ScatNet]()进行扩展，对此表示感谢  

###其他相关文献与资料  

  