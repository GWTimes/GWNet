//
//  EmailRegVC.m
//  GWNetDemo
//
//  Created by apple on 17/2/21.
//  Copyright © 2017年 YuanHongQiang. All rights reserved.
//

#import "EmailRegVC.h"

@interface EmailRegVC (){
    UITextField* _textFieldAccount;
    UITextField* _textFieldPassword;
    UITextField* _textFieldPasswordRePut;
    
}

@end

@implementation EmailRegVC

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
    
    _textFieldPasswordRePut=[[UITextField alloc] init];
    _textFieldPasswordRePut.placeholder=@"再次输入密码";
    _textFieldPasswordRePut.backgroundColor=[UIColor whiteColor];
    _textFieldPasswordRePut.frame=CGRectMake(10, 190, 300, 30);
    [self.view addSubview:_textFieldPasswordRePut];
    
    UIButton* buttonLogin=[BaseObj gtBaseButtonWithTitle:@"邮箱注册"];
    [buttonLogin addTarget:self action:@selector(startEmailReg:) forControlEvents:UIControlEventTouchUpInside];
    buttonLogin.frame=CGRectMake(10, 225, 300, 30);
    [self.view addSubview:buttonLogin];
    
    _textFieldAccount.text=@"theTest@qq.com";
    _textFieldPassword.text=@"abc123";
    _textFieldPasswordRePut.text=@"abc123";
}
#pragma mark - 以下是业务代码

#pragma mark 开始邮箱注册
-(void)startEmailReg:(UIButton*)bt{
    [GWNetSingleton regEmailWithEmail:_textFieldAccount.text withPwd:_textFieldPassword.text withRePwd:_textFieldPasswordRePut.text];
}
#pragma mark - 回调
-(void)gwNet:(nullable GWNet*)gwnet regEmailWillStart:(BOOL)success{
    NSLog(@"即将邮箱注册");
}
-(void)gwNet:(nullable GWNet*)gwnet regEmailEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json{
    if ([errorCode isEqualToString:@"0"]) {
        NSLog(@"邮箱注册 成功(%@:%@),返回的Json数据是:%@",errorCode,errorString,json);
    }else{
        NSLog(@"注册失败(%@):%@",errorCode,errorString);
    }
}
@end
