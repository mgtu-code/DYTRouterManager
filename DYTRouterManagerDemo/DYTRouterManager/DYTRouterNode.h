//
//  DYTRouterNode.h
//  idayoo
//
//  Created by mg on 15/9/18.
//  Copyright (c) 2015年 dayoo. All rights reserved.
//


/**
 * DYTRouterNode，路由节点类，将DYTRouterUrl转化成DYTRouterNode，提供给DYTRouterManager使用
 */
#import <UIKit/UIKit.h>
#import "DYTRouterUrl.h"
#import "DYTRouterProtocol.h"


@interface DYTRouterNode : NSObject

@property (nonatomic,readonly) DYTRouterUrlTransFormStyle transForm;

/**
 * 实例化方法
 *
 * @params DYTRouterUrl *url
 */
-(instancetype)initWithUrl:(DYTRouterUrl *)url;

/**
 * 返回node对应的UIViewController
 */
-(UIViewController<DYTRouterProtocol> *)getDYTViewController;

@end
