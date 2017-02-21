//
//  BaseVC.m
//  GWNetDemo
//
//  Created by apple on 17/2/21.
//  Copyright © 2017年 YuanHongQiang. All rights reserved.
//

#import "BaseVC.h"


@interface BaseVC ()

@end

@implementation BaseVC

-(void)dealloc{
    NSLog(@"界面被销毁,取消监听GWNet");
    [GWNetSingleton deleteTheDelegate:self];
}

-(instancetype)init{
    self=[super init];
    if (self) {
        NSLog(@"界面被创建,开始监听GWNet");
        [GWNetSingleton addTheDelegate:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:202/255.0 green:90/255.0 blue:86/255.0 alpha:1.0];
    
    UIButton* btBack=[BaseObj gtBaseButtonWithTitle:@"关闭此界面"];
    btBack.frame=CGRectMake(10, 25, 150, 30);
    [btBack addTarget:self action:@selector(disMiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btBack];
}
-(void)disMiss:(UIButton*)bt{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
