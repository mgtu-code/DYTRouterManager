//
//  DYTRouterUrl.h
//  idayoo
//
//  Created by mg on 15/9/18.
//  Copyright (c) 2015年 dayoo. All rights reserved.
//


/**
 * DYTRouterUrl，路由url解析类，解析出url中的各个参数，并通过可读属性提供访问
 */
#import <Foundation/Foundation.h>

/**
 * 加载的ViewController的类型，包括code 和 storyBoard
 */
typedef NS_ENUM(NSUInteger, DYTRouterUrlClassType){
    DYTRouterUrlClassTypeNotdifined = 0,
    DYTRouterUrlClassTypeCode,
    DYTRouterUrlClassTypeStoryboard,
};

/**
 * 弹出的ViewController的方式，包括present和push
 */
typedef NS_ENUM(NSUInteger, DYTRouterUrlTransFormStyle){
    DYTRouterUrlTransFormStyleNotdifined = 0,
    DYTRouterUrlTransFormStylePresent,
    DYTRouterUrlTransFormStylePush,
};


@interface DYTRouterUrl : NSObject

@property (nonatomic,strong,readonly) NSString *urlSchema;
@property (nonatomic,strong,readonly) NSString *className;
@property (nonatomic,readonly) DYTRouterUrlClassType classType;
@property (nonatomic,readonly) DYTRouterUrlTransFormStyle transFormStyle;
@property (nonatomic,strong,readonly) NSDictionary *urlParams;

/**
 * 实例化方法
 *
 * @params NSString *url
 */
-(instancetype)initWithUrl:(NSString *)url;

/**
 * 实例化方法
 *
 * @params NSString *urlSchema
 * @params NSString *className
 * @params DYTRouterUrlClassType classType
 * @params DYTRouterUrlTransFormStyle transFormStyle
 * @params NSDictionary *urlParams
 */
-(instancetype)initWithUrlSchema:(NSString *)urlSchema className:(NSString *)className classType:(DYTRouterUrlClassType)classType transFormStyle:(DYTRouterUrlTransFormStyle)transFormStyle urlParams:(NSDictionary *)urlParams;

@end
