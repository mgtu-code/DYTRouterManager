//
//  DYTRouterNode.m
//  idayoo
//
//  Created by mg on 15/9/18.
//  Copyright (c) 2015年 dayoo. All rights reserved.
//

#import "DYTRouterNode.h"


@interface DYTRouterNode ()

@property (nonatomic,strong) DYTRouterUrl *url;

@end


@implementation DYTRouterNode

-(instancetype)initWithUrl:(DYTRouterUrl *)url{
    if(self = [super init]){
        if(!url) {
            return nil;
        }
        _url = url;
    }
    return self;
}

-(instancetype)init{
    return [[[self class] alloc] initWithUrl:nil];
}

-(DYTRouterUrlTransFormStyle)transForm{
    return self.url.transFormStyle;
}

-(UIViewController<DYTRouterProtocol> *)returnController{
    switch (self.url.classType) {
        //className 为 main:mainVC,main是StoryBoard的文件名，mainVC是对应的ViewController的缩写
        case DYTRouterUrlClassTypeStoryboard:{
            NSArray *classNameList = [self.url.className componentsSeparatedByString:@":"];
            if(classNameList.count == 2){
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[classNameList objectAtIndex:0] bundle:nil];
                if(storyboard != nil){
                    return [storyboard instantiateViewControllerWithIdentifier:[self p_getFullClassNameByClassName:[classNameList objectAtIndex:1]]];
                }
            }
            break;
        }
        case DYTRouterUrlClassTypeNotdifined:
        case DYTRouterUrlClassTypeCode:{
            return [[NSClassFromString([self p_getFullClassNameByClassName:self.url.className]) alloc] init];
            break;
        }
    }
    return nil;
}

#pragma mark private method
-(NSString *)p_getFullClassNameByClassName:(NSString *)className{
    if(NSClassFromString(className)){
        return className;
    }
    NSString *controllerName = [className stringByAppendingString:@"Controller"];
    if(NSClassFromString(controllerName)){
        return controllerName;
    }
    NSString *viewControllerName = [className stringByAppendingString:@"ViewController"];
    if ( NSClassFromString(viewControllerName) ) {
        return viewControllerName;
    }
    return nil;
}

@end
