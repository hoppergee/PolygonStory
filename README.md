# 多边形的寓言

### 简介

一个纯Swift写的iOS练手的寓言小游戏，并上架[AppStore (Only For iPad)](https://itunes.apple.com/cn/app/%E5%A4%9A%E8%BE%B9%E5%BD%A2%E7%9A%84%E5%AF%93%E8%A8%80/id1173118858?mt=8)

Idea来自于[一个PolygonStory的网页](http://ncase.me/polygons/)，做出来的效果与原作效果基本一致，但由于只懂iOS的内容，所以与原作的HTML代码应该会有很大差别。

[这里可以看到该App的复杂效果演示](http://weibo.com/tv/v/EwyXSBoGL?fid=1034:845e2b05cd95ecc46d264f41f18290b4)

这次项目的学习点：

* 数据驱动视图的设计思路
* 动态走势图的绘制（贝塞尔曲线+定时器）
* 类棋盘的触摸板二维界面布置
* 实现触摸手势的综合复杂判断
  * 需要结合
    * 当前多边形与其周边同伴的心情
    * 多边形的位置（起始点与终点）
    * 手势状态（start/change/end）
  * 触摸手势划出设定边界的判断问题
* 多边形自行完成游戏（自己选点，自己做判断，每个多边形会根据周边的情况实时做出反应）
  * 通过让多边形自我移动的动画时间远超定时器从而达到多个多边形同时移动的假象
* 通过两张图的视差达到按钮点击下沉的动画效果

以上可见：其实我并没有使用很多复杂的控件，更多的是逻辑上的设计，自己还是蛮喜欢完这种小逻辑的。

### Wiki结构



动图演示如下：

![PolygonDemonstrate1](/Users/medusasa/Documents/iOS_Learning/PolygonStory/PolygonDemonstrate1.gif)



![PolygonDemonstrate2](/Users/medusasa/Documents/iOS_Learning/PolygonStory/PolygonDemonstrate2.gif)