# MaxEnt

这个repo存放利用MaxEnt模型进行物种分布预测的相关代码

需要的数据有：

1.物种分布信息，写成csv放在samples目录下面

2.气候条件。我之前下载的是tiff格式的图片，可以用tools目录下的bioclimatic_history.ncl转成asc文件后让MaxEnt模型读取

3.未来气候条件。我下载的是asc格式的文件，但是范围太大是全世界。可以用tools下面的工具处理下

具备以上数据以后就可以运行了，鼠标点点就可以完成模拟，具体可以参考附带的maxentTutorialv6.doc

##### 数据下载

历史气候数据：http://www.worldclim.org/

未来气候数据：http://www.ccafs-climate.org/

直接下载用于物种分布预测的Bioclimatic变量就可以了。。。

其他可用数据：

土壤相关：http://nelson.wisc.edu/sage/index.php

地形与坡度：http://www.fao.org/soils-portal/soil-survey/soil-maps-and-databases/harmonized-world-soil-database-v12/en
