//
//  LoginDemoVC.m
//  GWNetDemo
//
//  Created by apple on 17/2/21.
//  Copyright © 2017年 YuanHongQiang. All rights reserved.
//

#import "LoginDemoVC.h"

@interface LoginDemoVC (){
    UITextField* _textFieldAccount;
    UITextField* _textFieldPassword;
}

@end

@implementation LoginDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _textFieldAccount=[[UITextField alloc] init];
    _textFieldAccount.placeholder=@"输入账号";
    _textFieldAccount.backgroundColor=[UIColor whiteColor];
    _textFieldAccount.frame=CGRectMake(10, 120, 300, 30);
    [self.view addSubview:_textFieldAccount];
    
    _textFieldPassword=[[UITextField alloc] init];
    _textFieldPassword.placeholder=@"输入密码";
    _textFieldPassword.backgroundColor=[UIColor whiteColor];
    _textFieldPassword.frame=CGRectMake(10, 155, 300, 30);
    [self.view addSubview:_textFieldPassword];
    
    UIButton* buttonLogin=[BaseObj gtBaseButtonWithTitle:@"立即普通登录"];
    [buttonLogin addTarget:self action:@selector(startLogin:) forControlEvents:UIControlEventTouchUpInside];
    buttonLogin.frame=CGRectMake(10, 190, 300, 30);
    [self.view addSubview:buttonLogin];
    
    
    _textFieldAccount.text=@"theTest@qq.com";
    _textFieldPassword.text=@"abc123";
    
}


#pragma mark - 以下是业务代码

#pragma mark 开始登录
-(void)startLogin:(UIButton*)bt{
    [GWNetSingleton loginWithUserName:_textFieldAccount.text withPassword:_textFieldPassword.text withAppleToken:nil];
}
#pragma mark 登录回调
-(void)gwNet:(nullable GWNet*)gwnet loginWillStart:(BOOL)success{
    NSLog(@"即将开始普通登录");
}
-(void)gwNet:(nullable GWNet*)gwnet loginEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json{
    if ([errorCode isEqualToString:@"0"]) {
        NSLog(@"登录成功,(%@:%@),返回的Json数据是:%@",errorCode,errorString,json);
    }else{
        NSLog(@"登录失败(%@):%@",errorCode,errorString);
    }
}
@end
