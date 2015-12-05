//
//  DYTRouterManager.h
//  idayoo
//
//  Created by mg on 15/9/18.
//  Copyright (c) 2015年 dayoo. All rights reserved.
//


/**
 * DYTRouterManager，路由节核心类，负责ViewController的处理
 */
#import <UIKit/UIKit.h>
#import "DYTRouterUrl.h"
#import "DYTRouterProtocol.h"


//公共配置：urlSchema前缀
static NSString *const G_DYTRouterManager_defaultUrlSchema = @"DYTapp";


@interface DYTRouterManager : NSObject

/**
 * 单例初始化
 */
+(instancetype)shareInstance;

/**
 * 打开对应的ViewController(Url)
 *
 * @params NSString *url，需要打开页面的url
 * @params UIViewController *delegate，打开页面的原ViewController
 */
-(void)openUrl:(NSString *)url delegate:(UIViewController *)delegate;

/**
 * 打开对应的ViewController
 *
 * @params NSString *url，需要打开页面的url
 * @params UIViewController *delegate，打开页面的原ViewController
 */
-(void)openWithUrlSchema:(NSString *)urlSchema className:(NSString *)className classType:(DYTRouterUrlClassType)classType transFormStyle:(DYTRouterUrlTransFormStyle)transFormStyle urlParams:(NSDictionary *)urlParams delegate:(UIViewController *)delegate;

@end
