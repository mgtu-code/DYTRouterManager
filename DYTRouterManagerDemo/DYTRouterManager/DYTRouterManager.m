//
//  DYTRouterManager.m
//  idayoo
//
//  Created by mg on 15/9/18.
//  Copyright (c) 2015年 dayoo. All rights reserved.
//

#import "DYTRouterManager.h"
#import "DYTRouterUrl.h"
#import "DYTRouterNode.h"


@interface DYTRouterManager ()

@end


@implementation DYTRouterManager

#pragma mark - init
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static DYTRouterManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[[self class ]alloc] initInstance];
    });
    return manager;
}

-(instancetype)init{
    return [[[self class] alloc] shareInstance];
}

-(instancetype)initInstance{
    if(self = [super init]){
    }
    return self;
}

#pragma mark - public
-(void)openUrl:(NSString *)url delegate:(UIViewController *)delegate{
    DYTRouterUrl *routerUrl = [[DYTRouterUrl alloc] initWithUrl:url];
    [self p_openDYTRouterUrl:routerUrl delegate:delegate];
}

-(void)openWithUrlSchema:(NSString *)urlSchema className:(NSString *)className classType:(DYTRouterUrlClassType)classType transFormStyle:(DYTRouterUrlTransFormStyle)transFormStyle urlParams:(NSDictionary *)urlParams delegate:(UIViewController *)delegate{
    DYTRouterUrl *routerUrl = [[DYTRouterUrl alloc] initWithUrlSchema:urlSchema className:className classType:classType transFormStyle:transFormStyle urlParams:urlParams];
    [self p_openDYTRouterUrl:routerUrl delegate:delegate];
}

#pragma mark - private
//打开url
-(void)p_openDYTRouterUrl:(DYTRouterUrl *)url delegate:(UIViewController *)delegate{
    if(!url || ![url isKindOfClass:[DYTRouterUrl class]]){
        return;
    }
    
    if(!delegate || ![delegate isKindOfClass:[UIViewController class]]){
        return;
    }
    
    if(![url.urlSchema isEqualToString:G_DYTRouterManager_defaultUrlSchema]){
        return;
    }
    
    //url转换成node
    DYTRouterNode *routerNode = [[DYTRouterNode alloc] initWithUrl:url];
    UIViewController<DYTRouterProtocol> *willPresentController = [routerNode getDYTViewController];
    
    //弹出方式
    DYTRouterUrlTransFormStyle transForm = routerNode.transForm;
    
    //返回对象是UIViewController
    if(!willPresentController || ![willPresentController isKindOfClass:[UIViewController class]]){
        return;
    }
    
    //处理相应的参数
    if([willPresentController respondsToSelector:@selector(dytRouterManager_handleParamsByRouterManager:urlParams:)]){
        [willPresentController dytRouterManager_handleParamsByRouterManager:self urlParams:url.urlParams];
    }
        
    if(!delegate.navigationController){
        transForm = DYTRouterUrlTransFormStylePresent;
    }
    
    //处理页面打开
    switch (transForm) {
        case DYTRouterUrlTransFormStyleNotdifined:
        case DYTRouterUrlTransFormStylePresent:{
            [delegate presentViewController:willPresentController animated:YES completion:nil];
            break;
        }
        case DYTRouterUrlTransFormStylePush:{
            if([delegate isKindOfClass:[UINavigationController class]]){
                [(UINavigationController *)delegate pushViewController:willPresentController animated:YES];
            }else{
                [delegate.navigationController pushViewController:willPresentController animated:YES];
            }
            break;
        }
    }
}

@end

