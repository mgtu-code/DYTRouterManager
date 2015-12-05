//
//  BViewController.m
//  DYTRouterManager
//
//  Created by tumg on 15/12/5.
//  Copyright (c) 2015年 tumg. All rights reserved.
//

#import "BViewController.h"
#import "DYTRouterProtocol.h"
#import "DYTRouterManager.h"


@interface BViewController ()<DYTRouterProtocol>

@property (nonatomic,strong) DYTRouterManager *routerManager;
@property (nonatomic,strong) UIButton *rootButton;

@end


@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _routerManager = [DYTRouterManager shareInstance];
    [self.view addSubview:self.rootButton];
}

-(void)p_handRootButtonClick{
    [self.routerManager openUrl:@"DYTapp://name=ViewController&transformStyle=present&type=code/?paramBR=cat" delegate:self];
}


#pragma mark - DYTRouterProtocol
-(void)dytRouterManager_back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dytRouterManager_handleParamsByRouterManager:(DYTRouterManager *)routerManager urlParams:(NSDictionary *)urlParams{
    NSLog(@"BViewController-handleParams:%@",urlParams);
}

-(UIButton *)rootButton{
    if(_rootButton == nil){
        _rootButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _rootButton.frame = CGRectMake((self.view.frame.size.width-160)/2, 60, 160, 40);
        _rootButton.backgroundColor = [UIColor blueColor];
        [_rootButton setTitle:@"打开 ViewController" forState:UIControlStateNormal];
        [_rootButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rootButton addTarget:self action:@selector(p_handRootButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rootButton;
}

@end
