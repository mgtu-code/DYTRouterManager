//
//  ViewController.m
//  DYTRouterManager
//
//  Created by tumg on 15/12/5.
//  Copyright (c) 2015年 tumg. All rights reserved.
//

#import "ViewController.h"
#import "DYTRouterProtocol.h"
#import "DYTRouterManager.h"

@interface ViewController ()<DYTRouterProtocol>

@property (nonatomic,strong) DYTRouterManager *routerManager;
@property (nonatomic,strong) UIButton *aButton;
@property (nonatomic,strong) UIButton *bButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    _routerManager = [DYTRouterManager shareInstance];
    
    [self.view addSubview:self.aButton];
    [self.view addSubview:self.bButton];

}

-(void)p_handAButtonClick{
    [self.routerManager openUrl:@"DYTapp://name=AViewController&transformStyle=present&type=code/?paramA=apple" delegate:self];
}

-(void)p_handBButtonClick{
    [self.routerManager openUrl:@"DYTapp://name=BViewController&transformStyle=present&type=code/?paramB=boy" delegate:self];
}

#pragma mark - DYTRouterProtocol
-(void)dytRouterManager_back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dytRouterManager_handleParamsByRouterManager:(DYTRouterManager *)routerManager urlParams:(NSDictionary *)urlParams{
    NSLog(@"ViewController-handleParams:%@",urlParams);
}

-(UIButton *)aButton{
    if(_aButton == nil){
        _aButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _aButton.frame = CGRectMake((self.view.frame.size.width-160)/2, 60, 160, 40);
        _aButton.backgroundColor = [UIColor blueColor];
        [_aButton setTitle:@"打开A ViewController" forState:UIControlStateNormal];
        [_aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_aButton addTarget:self action:@selector(p_handAButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aButton;
}

-(UIButton *)bButton{
    if(_bButton == nil){
        _bButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _bButton.frame = CGRectMake((self.view.frame.size.width-160)/2, 110, 160, 40);
        _bButton.backgroundColor = [UIColor blueColor];
        [_bButton setTitle:@"打开B ViewController" forState:UIControlStateNormal];
        [_bButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bButton addTarget:self action:@selector(p_handBButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bButton;
}

@end
