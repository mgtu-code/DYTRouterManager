//
//  DYTRouterProtocol.h
//  idayoo
//
//  Created by mg on 15/9/18.
//  Copyright (c) 2015年 dayoo. All rights reserved.
//


/**
 * DYTRouterProtocol，使用RouterManager打开的ViewController需蹲循本协议
 */
#import <Foundation/Foundation.h>


@class DYTRouterManager;


@protocol DYTRouterProtocol <NSObject>

@optional
/**
 * 当前ViewController返回处理
 */
-(void)dytRouterManager_back;

/**
 * 处理RouterManager传递过来的urlParams，一般用于ViewController的初始化
 */
-(void)dytRouterManager_handleParamsByRouterManager:(DYTRouterManager *)routerManager urlParams:(NSDictionary *)urlParams;

@end
