//
//  PhoneRegVC.m
//  GWNetDemo
//
//  Created by apple on 17/2/21.
//  Copyright © 2017年 YuanHongQiang. All rights reserved.
//

#import "PhoneRegVC.h"
@interface PhoneRegVC (){
    UITextField* _textFieldCityCode;
    UITextField* _textFieldAccount;
    UITextField* _textFieldPassword;
    UITextField* _textFieldPasswordReInput;
    
    UITextField* _textFieldMsgCode;//短信验证码
}
@end
@implementation PhoneRegVC
- (void)viewDidLoad {
    [super viewDidLoad];
    _textFieldCityCode=[[UITextField alloc] init];
    _textFieldCityCode.textAlignment=NSTextAlignmentCenter;
    _textFieldCityCode.text=@"86";
    _textFieldCityCode.placeholder=@"国码";
    _textFieldCityCode.backgroundColor=[UIColor whiteColor];
    _textFieldCityCode.frame=CGRectMake(10, 120, 50, 30);
    [self.view addSubview:_textFieldCityCode];
    
    _textFieldAccount=[[UITextField alloc] init];
    _textFieldAccount.placeholder=@"输入手机号";
    _textFieldAccount.backgroundColor=[UIColor whiteColor];
    _textFieldAccount.frame=CGRectMake(65, 120, 245, 30);
    [self.view addSubview:_textFieldAccount];
    
    _textFieldPassword=[[UITextField alloc] init];
    _textFieldPassword.placeholder=@"输入密码";
    _textFieldPassword.backgroundColor=[UIColor whiteColor];
    _textFieldPassword.frame=CGRectMake(10, 155, 300, 30);
    [self.view addSubview:_textFieldPassword];
    
    _textFieldPasswordReInput=[[UITextField alloc] init];
    _textFieldPasswordReInput.placeholder=@"再次输入密码";
    _textFieldPasswordReInput.backgroundColor=[UIColor whiteColor];
    _textFieldPasswordReInput.frame=CGRectMake(10, 190, 300, 30);
    [self.view addSubview:_textFieldPasswordReInput];
    
    _textFieldMsgCode=[[UITextField alloc] init];
    _textFieldMsgCode.placeholder=@"短信验证码";
    _textFieldMsgCode.backgroundColor=[UIColor whiteColor];
    _textFieldMsgCode.frame=CGRectMake(10, 225, 145, 30);
    [self.view addSubview:_textFieldMsgCode];
    
    UIButton* buttonSendMsgCode=[BaseObj gtBaseButtonWithTitle:@"发验证码"];
    [buttonSendMsgCode addTarget:self action:@selector(startSendMsgCode:) forControlEvents:UIControlEventTouchUpInside];
    buttonSendMsgCode.frame=CGRectMake(160, 225, 150, 30);
    [self.view addSubview:buttonSendMsgCode];
    
    UIButton* buttonPhoReg=[BaseObj gtBaseButtonWithTitle:@"立即手机注册"];
    [buttonPhoReg addTarget:self action:@selector(startPhoneReg:) forControlEvents:UIControlEventTouchUpInside];
    buttonPhoReg.frame=CGRectMake(10, 260, 300, 30);
    [self.view addSubview:buttonPhoReg];
    
    
    _textFieldPassword.text=@"abc123";
    _textFieldPasswordReInput.text=@"abc1234";

}
#pragma mark - 以下是业务代码
-(void)startSendMsgCode:(UIButton*)bt{
    [GWNetSingleton sendSmsWithCountryCode:_textFieldCityCode.text withPhoneNum:_textFieldAccount.text];
}
-(void)startPhoneReg:(UIButton*)bt{
    if (![_textFieldPassword.text isEqualToString:_textFieldPasswordReInput.text]) {
        NSLog(@"两次输入的密码不一致,请检查您的密码");
        return;
    }
    
    [GWNetSingleton checkSmsWithCountryCode:_textFieldCityCode.text withPhoneNum:_textFieldAccount.text withVerifyCode:_textFieldMsgCode.text];
}
#pragma mark - 回调
#pragma mark 发验证码
-(void)gwNet:(nullable GWNet*)gwnet sendSmsWillStart:(BOOL)success{
    NSLog(@"即将发短信验证码");
}
-(void)gwNet:(nullable GWNet*)gwnet sendSmsEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json{
    if ([errorCode isEqualToString:@"0"]) {
        NSLog(@"发送成功(%@:%@),返回的Json数据是:%@",errorCode,errorString,json);
    }else{
        NSLog(@"发送失败(%@):%@",errorCode,errorString);
    }
}
#pragma mark 检查验证码
-(void)gwNet:(nullable GWNet*)gwnet checkSmsWillStart:(BOOL)success{
    NSLog(@"即将检查短信验证码是否正确");
}
-(void)gwNet:(nullable GWNet*)gwnet checkSmsEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json{
    if ([errorCode isEqualToString:@"0"]) {
        NSLog(@"检查成功,(%@:%@),返回的Json数据是:%@",errorCode,errorString,json);
        //检查验证码是正确的就开始用手机号注册
        [GWNetSingleton regPhoneWithNum:_textFieldAccount.text withCountryCode:_textFieldCityCode.text withPassword:_textFieldPassword.text withRePwd:_textFieldPasswordReInput.text withSmsCode:_textFieldMsgCode.text];
    }else{
        NSLog(@"检查失败(%@):%@",errorCode,errorString);
    }
}
#pragma mark 手机注册
-(void)gwNet:(nullable GWNet*)gwnet regPhoneWillStart:(BOOL)success{
    NSLog(@"即将用手机号注册");
}
-(void)gwNet:(nullable GWNet*)gwnet regPhoneEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json{
    if ([errorCode isEqualToString:@"0"]) {
        NSLog(@"手机注册成功,(%@:%@),返回的Json数据是:%@",errorCode,errorString,json);
    }else{
        NSLog(@"手机注册失败(%@):%@",errorCode,errorString);
    }
}
@end
