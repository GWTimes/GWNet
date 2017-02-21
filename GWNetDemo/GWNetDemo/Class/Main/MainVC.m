//
//  MainVC.m
//  GWNetDemo
//
//  Created by apple on 17/2/21.
//  Copyright © 2017年 YuanHongQiang. All rights reserved.
//

#import "MainVC.h"
#import "BaseObj.h"
#import "LoginDemoVC.h"
#import "EmailRegVC.h"
#import "PhoneRegVC.h"
#import "MixLoginVC.h"

@interface MainVC ()
@end
@implementation MainVC
-(instancetype)init{
    self=[super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:154/255.0 green:41/255.0 blue:204/255.0 alpha:1.0];
    self.tabBar.hidden=YES;

    UIButton* btLoginDemo=[BaseObj gtBaseButtonWithTitle:@"普通登录演示"];
    [btLoginDemo addTarget:self action:@selector(demoLogin:) forControlEvents:UIControlEventTouchUpInside];
    btLoginDemo.frame=CGRectMake(10, 70, 200, 30);
    [self.view addSubview:btLoginDemo];
    
    UIButton* btEmailRegDemo=[BaseObj gtBaseButtonWithTitle:@"邮箱注册演示"];
    [btEmailRegDemo addTarget:self action:@selector(demoEmailReg:) forControlEvents:UIControlEventTouchUpInside];
    btEmailRegDemo.frame=CGRectMake(10, 105, 200, 30);
    [self.view addSubview:btEmailRegDemo];
    
    UIButton* btPhoneRegDemo=[BaseObj gtBaseButtonWithTitle:@"手机注册演示"];
    [btPhoneRegDemo addTarget:self action:@selector(demoPhoneReg:) forControlEvents:UIControlEventTouchUpInside];
    btPhoneRegDemo.frame=CGRectMake(10, 140, 200, 30);
    [self.view addSubview:btPhoneRegDemo];
    
    UIButton* btMixLoginDemo=[BaseObj gtBaseButtonWithTitle:@"混合登录演示"];
    [btMixLoginDemo addTarget:self action:@selector(demoMixLogin:) forControlEvents:UIControlEventTouchUpInside];
    btMixLoginDemo.frame=CGRectMake(10, 175, 200, 30);
    [self.view addSubview:btMixLoginDemo];
    
    
    UILabel* labelInfo=[[UILabel alloc] init];
    labelInfo.backgroundColor=[UIColor darkGrayColor];
    labelInfo.frame=CGRectMake(10, 210, 300, 60);
    labelInfo.numberOfLines=0;
    labelInfo.text=@"所有的输出会在调试板输出,不会在界面输出,请留意日志输出";
    labelInfo.textColor=[UIColor whiteColor];
    [self.view addSubview:labelInfo];
    
}
-(void)demoLogin:(UIButton*)bt{
    LoginDemoVC* loginVCs=[[LoginDemoVC alloc] init];
    [self presentViewController:loginVCs animated:YES completion:nil];
}

-(void)demoEmailReg:(UIButton*)bt{
    EmailRegVC* emailRegVCs=[[EmailRegVC alloc] init];
    [self presentViewController:emailRegVCs animated:YES completion:nil];
}

-(void)demoPhoneReg:(UIButton*)bt{
    PhoneRegVC* phoneVCs=[[PhoneRegVC alloc] init];
    [self presentViewController:phoneVCs animated:YES completion:nil];
}

-(void)demoMixLogin:(UIButton*)bt{
    MixLoginVC* loginMIXVCs=[[MixLoginVC alloc] init];
    [self presentViewController:loginMIXVCs animated:YES completion:nil];
}
@end
