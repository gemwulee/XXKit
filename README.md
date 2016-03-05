# 1. 项目如何搭建
[xcode用workspace搭建高效的复用工程](http://iosxxx.com/blog/2016-01-23-xcodeda-jian-gao-xiao-de-fu-yong-gong-cheng.html)

# 2. XXFPSEngine
FPS帧率统计,CADisplayLink计算大于1秒的间隔内 屏幕刷新的次数 除以时间  就得到了帧率

# 3. TabBar
重写了UITabBar,UITabBarController,UITabBarItem,将UITabBar作为UIView实现，自定义内部按钮。提高扩展性

# 4. XXNavigationController
重写导航栏，提供第三方接口解决导航栏的问题

# 5. ObjectSwizzleMethod
Hook架构，用来替换系统方法，解决一下系统bug