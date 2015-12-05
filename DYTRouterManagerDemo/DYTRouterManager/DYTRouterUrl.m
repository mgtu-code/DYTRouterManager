//
//  DYTRouterUrl.m
//  idayoo
//
//  Created by mg on 15/9/18.
//  Copyright (c) 2015年 dayoo. All rights reserved.
//

#import "DYTRouterUrl.h"
#import <CommonCrypto/CommonDigest.h>
#import "RegexKitLite.h"

static NSString *const p_urlSchemaKey = @"urlSchema";
static NSString *const p_classNameKey = @"className";
static NSString *const p_classTypeKey = @"classType";
static NSString *const p_transFormStyleKey = @"transFormStyle";
static NSString *const p_urlParamsKey = @"urlParams";

@interface DYTRouterUrl ()

@property (nonatomic,strong,readwrite) NSString *urlSchema;
@property (nonatomic,strong,readwrite) NSString *className;
@property (nonatomic,readwrite) DYTRouterUrlClassType classType;
@property (nonatomic,readwrite) DYTRouterUrlTransFormStyle transFormStyle;
@property (nonatomic,strong,readwrite) NSDictionary *urlParams;

@property (nonatomic,strong) NSCache *cache;

@end

@implementation DYTRouterUrl

-(instancetype)initWithUrl:(NSString *)url{
    if(self = [super init]){
        _cache = [self shareInstanceCache];
        [self p_parseUrl:url];
    }
    return self;
}

-(instancetype)initWithUrlSchema:(NSString *)urlSchema className:(NSString *)className classType:(DYTRouterUrlClassType)classType transFormStyle:(DYTRouterUrlTransFormStyle)transFormStyle urlParams:(NSDictionary *)urlParams{
    if(self = [super init]){
        self.urlSchema = urlSchema;
        self.className = className;
        self.classType = classType;
        self.transFormStyle = transFormStyle;
        self.urlParams = urlParams;
    }
    return self;
}

#pragma mark - private
//将url进行解析，并通过NSCache进行缓存
-(void)p_parseUrl:(NSString *)url{
    //如果url为nil，则不做任何处理
    if(!url){
        return;
    }
    
    //获取缓存值
    NSString *urlMd5Key = [self getMd5String:url];
    NSDictionary *cacheDictionary = [self.cache objectForKey:urlMd5Key];
    
    if(cacheDictionary){
        self.urlSchema = [cacheDictionary objectForKey:p_urlSchemaKey];
        self.className = [cacheDictionary objectForKey:p_classNameKey];
        self.classType = [[cacheDictionary objectForKey:p_classTypeKey] integerValue];
        self.transFormStyle = [[cacheDictionary objectForKey:p_transFormStyleKey] integerValue];
        self.urlParams = [cacheDictionary objectForKey:p_urlParamsKey];
    }else if(urlMd5Key){
        NSMutableDictionary *cacheDictionary = [[NSMutableDictionary alloc] init];
        //整体解析规则
        NSString *regString = @"^(.*)://([^/^\\?.]*)?/?\\??(.*)$";
        
        /*url Schema 部分解析*/
        NSString *urlSchema = [url stringByMatching:regString capture:1];
        if(urlSchema){
            self.urlSchema = urlSchema;
            [cacheDictionary setObject:urlSchema forKey:p_urlSchemaKey];
        }
        
        /*url Class 部分解析*/
        NSString *urlClassString = [url stringByMatching:regString capture:2];
        if(urlClassString){
            //className
            NSString *classNameRegString = @".*name=([:\\w]*).*";
            NSString *classNameString = [urlClassString stringByMatching:classNameRegString capture:1];
            if(classNameString){
                self.className = classNameString;
                [cacheDictionary setObject:classNameString forKey:p_classNameKey];
            }
            
            //classType
            NSString *classTypeRegString = @".*type=([code|storyboard]*).*";
            NSString *classTypeString = [urlClassString stringByMatching:classTypeRegString capture:1];
            if(classTypeString){
                self.classType = [self p_classTypeFromString:classTypeString];
                [cacheDictionary setObject:[NSNumber numberWithInteger:self.classType] forKey:p_classTypeKey];
            }
            
            //transFormStyle
            NSString *transFormStyleRegString = @".*transformStyle=([present|push]*).*";
            NSString *transFormStyleString = [urlClassString stringByMatching:transFormStyleRegString capture:1];
            if(transFormStyleString){
                self.transFormStyle = [self p_transFormStyleFromString:transFormStyleString];
                [cacheDictionary setObject:[NSNumber numberWithInteger:self.transFormStyle] forKey:p_transFormStyleKey];
            }
        }
        
        /*url params 部分解析*/
        NSString *urlParamsString = [url stringByMatching:regString capture:3];
        NSArray *urlParamItems = [urlParamsString componentsSeparatedByString:@"&"];
        
        NSString *paramsRegString = @"(.*?)=(.*)$";
        NSMutableDictionary *urlParamsList = [[NSMutableDictionary alloc] init];
        [urlParamItems enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            NSString *key = [obj stringByMatching:paramsRegString capture:1];
            NSString *value = [obj stringByMatching:paramsRegString capture:2];
            if(key && value){
                [urlParamsList setObject:value forKey:key];
            }
        }];
        
        self.urlParams = [NSDictionary dictionaryWithDictionary:urlParamsList];
        [cacheDictionary setObject:self.urlParams forKey:p_urlParamsKey];
        
        //设置缓存
        [self.cache setObject:cacheDictionary forKey:urlMd5Key];
    }
}

-(DYTRouterUrlClassType)p_classTypeFromString:(NSString *)classTypeString{
    if([classTypeString isEqualToString:@"code"]){
        return DYTRouterUrlClassTypeCode;
    }
    if([classTypeString isEqualToString:@"storyboard"]){
        return DYTRouterUrlClassTypeStoryboard;
    }
    return DYTRouterUrlClassTypeNotdifined;
}

-(DYTRouterUrlTransFormStyle)p_transFormStyleFromString:(NSString *)transFormStyleString{
    if([transFormStyleString isEqualToString:@"present"]){
        return DYTRouterUrlTransFormStylePresent;
    }
    if([transFormStyleString isEqualToString:@"push"]){
        return DYTRouterUrlTransFormStylePush;
    }
    return DYTRouterUrlTransFormStylePresent;
}

//获取字符串的md5
-(NSString *)getMd5String:(NSString*)str{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

//单例的NSCache
-(NSCache *)shareInstanceCache{
    static dispatch_once_t onceToken;
    static NSCache *cache = nil;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
    });
    return cache;
}
@end
