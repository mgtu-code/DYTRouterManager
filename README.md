# DYTRouterManager
DYTRouterManager，是实现ViewController路由管理的组件，适用于非storyBoard场景下，各个ViewController之间跳转管理，采用类似Web Url 的格式，ViewController之间通过约定的字符串（DYTapp://name=B&transformStyle=present&type=code/?param1=b1）进行 push 或 present。

＃组件初始化＃

self.routerManager = [DYTRouterManager shareInstance];

＃组件使用（viewController跳转）＃

[self.routerManager openUrl:@"DYTapp://name=BViewController&transformStyle=present&type=code/?paramAB=blue" delegate:self];
