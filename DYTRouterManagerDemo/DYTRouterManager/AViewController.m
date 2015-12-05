//
//  AViewController.m
//  DYTRouterManager
//
//  Created by tumg on 15/12/5.
//  Copyright (c) 2015年 tumg. All rights reserved.
//

#import "AViewController.h"
#import "DYTRouterProtocol.h"
#import "DYTRouterManager.h"


@interface AViewController ()<DYTRouterProtocol>

@property (nonatomic,strong) DYTRouterManager *routerManager;
@property (nonatomic,strong) UIButton *bButton;
@property (nonatomic,strong) UIButton *backButton;

@end


@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    _routerManager = [DYTRouterManager shareInstance];
    
    [self.view addSubview:self.bButton];
    [self.view addSubview:self.backButton];
}

-(void)p_handBButtonClick{
    [self.routerManager openUrl:@"DYTapp://name=BViewController&transformStyle=present&type=code/?paramAB=blue" delegate:self];
}

#pragma mark - DYTRouterProtocol
-(void)dytRouterManager_back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dytRouterManager_handleParamsByRouterManager:(DYTRouterManager *)routerManager urlParams:(NSDictionary *)urlParams{
    NSLog(@"AViewController-handleParams:%@",urlParams);
}

-(UIButton *)bButton{
    if(_bButton == nil){
        _bButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _bButton.frame = CGRectMake((self.view.frame.size.width-160)/2, 40, 160, 40);
        _bButton.backgroundColor = [UIColor blueColor];
        [_bButton setTitle:@"打开B ViewController" forState:UIControlStateNormal];
        [_bButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bButton addTarget:self action:@selector(p_handBButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bButton;
}

-(UIButton *)backButton{
    if(_backButton == nil){
        _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _backButton.frame = CGRectMake((self.view.frame.size.width-160)/2, 110, 160, 40);
        _backButton.backgroundColor = [UIColor blueColor];
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(dytRouterManager_back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
