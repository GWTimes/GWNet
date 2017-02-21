//
//  MixLoginVC.m
//  GWNetDemo
//
//  Created by apple on 17/2/21.
//  Copyright © 2017年 YuanHongQiang. All rights reserved.
//

#import "MixLoginVC.h"

@interface MixLoginVC (){
    UITextField* _textFieldAccount;
}

@end

@implementation MixLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _textFieldAccount=[[UITextField alloc] init];
    _textFieldAccount.placeholder=@"输入邮箱或者手机或者其它账号标识";
    _textFieldAccount.backgroundColor=[UIColor whiteColor];
    _textFieldAccount.frame=CGRectMake(10, 120, 300, 30);
    [self.view addSubview:_textFieldAccount];
    
    UIButton* buttonLogin=[BaseObj gtBaseButtonWithTitle:@"混合登录"];
    [buttonLogin addTarget:self action:@selector(startMixLogin:) forControlEvents:UIControlEventTouchUpInside];
    buttonLogin.frame=CGRectMake(10, 155, 300, 30);
    [self.view addSubview:buttonLogin];
    
    _textFieldAccount.text=@"theTest@qq.com";
}
#pragma mark - 以下是业务代码

#pragma mark 开始登录
-(void)startMixLogin:(UIButton*)bt{
    [GWNetSingleton thirdLoginWithPlatformType:@"3" withUnionID:_textFieldAccount.text withUser:nil withPassword:nil withAppleToken:nil withOption:@"3" withStoreID:nil];
}
-(void)gwNet:(nullable GWNet*)gwnet thirdLoginWillStart:(BOOL)success{
    NSLog(@"即将混合登录");
}
-(void)gwNet:(nullable GWNet*)gwnet thirdLoginEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json{
    if ([errorCode isEqualToString:@"0"]) {
        NSLog(@"混合登录成功,(%@:%@),返回的Json数据是:%@",errorCode,errorString,json);
    }else{
        NSLog(@"混合登录失败(%@):%@",errorCode,errorString);
    }
}
@end
