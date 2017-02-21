//
//  GWNet.h
//  GWNet
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 YHQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYDelegates.h"
#import <CommonCrypto/CommonDigest.h>

#ifndef GWNetSingleton
#define GWNetSingleton [GWNet shareInstance]
#endif

@protocol GWNetDelegate;
@interface GWNet : NSObject

@property(nonatomic,assign)NSInteger theTag;//这个相当于Tag
@property(nonatomic,copy,nullable)NSString* theTagString;//这个相当于String类型的Tag
@property(nonatomic,strong,nullable)NSMutableDictionary<NSString*,id>* theTagUserInfo;//这个是dic型的Tag


#pragma mark - 获取单例
/**获取单例,注意,本程序并不是全单例,而是半单例,本程序并没有重写alloc方法,所以alloc出来的依然是独立的地址*/
+(nullable instancetype)shareInstance;//获取单例

#pragma mark - 多播代理
/**没有特殊情况的话一般不需要用多播代理*/
-(void)addTheDelegate:(nullable id)delegate;//添加代理,重复的不会添加
-(void)deleteTheDelegate:(nullable id)delegate;//删除代理
-(void)deleteAllTheDelegate;//删除所有代理

#pragma mark - 单播代理
/**推荐使用单播代理就行了*/
@property(nonatomic,weak,nullable)id<GWNetDelegate> delegate;//单代理

#pragma mark - 必需设置的参数,如果不设置这些参数,会导致SDK传递的信息不正确
/**
 中文简体  中文繁体 英文 日语 韩语 德语 俄语
 zh-Hans zh-Hant en  ja  ko   de  ru ,其它语言请自行查询
 */
@property(nonatomic,copy,nonnull)NSString* theAppLanguage;//设置SDK的语言,如果服务器支持的话,服务器会返回相应的语言,默认为iOS系统语言
@property(nonatomic,copy,nonnull)NSString* theAppVersion;//APP的版本,类似于 2.3.4.7 这样的版本号,默认为 0.0.0.0
@property(nonatomic,copy,nonnull)NSString* theAppName;//App名称,请尽可能提供相应的名称
@property(nonatomic,copy,nonnull)NSString* theAppId;//APPID要与技威公司联系申请,否则SDK不能正常使用
@property(nonatomic,copy,nonnull)NSString* theAppToken;//AppToken要与技威公司联系申请,否则SDK不能正常使用

#pragma mark - 登录
//关于ID号,(10000|0x80000000 = -2147473648, -2147473648&0x7fffffff = 10000,01000是显示给用户的ID号,-2147473648是传给服务器的,它们之间要互相转换)
-(void)loginWithUserName:(nullable NSString*)name//可以为手机,如 +86-15200002222,或者邮箱地址,或者ID号,例如-2147473648
            withPassword:(nullable NSString*)pwd//密码,需要32位的md5加密处理,如果提供明文密码,内部会自动加密
          withAppleToken:(nullable NSString*)token;//苹果设备Token,用来远程推送,可空,空时则无法推送
-(nullable NSDictionary*)gtLoginResult;//获取服务器返回的Json数据,如果有的话

#pragma mark - 第三方登录
-(void)thirdLoginWithPlatformType:(nullable NSString*)platformType//平台,1.微信 2.匿名登录 3 混合登录 ,此参数不可空
                      withUnionID:(nullable NSString*)unionID//第三方平台的唯一标识符,如果是匿名登录,提供设备的唯一标识即可,不可空
                         withUser:(nullable NSString*)user//用户名,可为手机,如+86-15200002222,或邮箱,或ID号,如010000,绑定账号时不可空
                     withPassword:(nullable NSString*)pwd//密码,需要32位的md5加密处理,如果提供明文密码,内部会自动加密,绑定账号时不可空
                   withAppleToken:(nullable NSString*)token//苹果设备Token,用来远程推送,可空,空时则无法推送
                       withOption:(nullable NSString*)option//1仅登录 2绑定老用户并登录 3登录,若不存在则自动注册
                      withStoreID:(nullable NSString*)storeID;//商城ID,需要商城版功能时必须上传,可空,不懂的话留空即可
-(nullable NSDictionary*)gtThirdLoginResult;

#pragma mark - 退出登录
-(void)unLoginWithUserId:(nullable NSString*)userId//这个应该从登录时返回的json里获取
           withSessionId:(nullable NSString*)sessionId;//这个应该从登录时返回的json里获取
-(nullable NSDictionary*)gtUnLoginResult;//获取服务器返回的Json数据,如果有的话
#pragma mark - 邮箱注册
-(void)regEmailWithEmail:(nullable NSString*)name //邮箱地址
                 withPwd:(nullable NSString*)pwd //密码,需要32位的md5加密处理,如果提供明文密码,内部会自动加密
               withRePwd:(nullable NSString*)rePwd;//再次密码,两次的密码应当一致
-(nullable NSDictionary*)gtRegEmailResult;//获取服务器返回的Json数据,如果有的话
#pragma mark - 手机号注册
-(void)regPhoneWithNum:(nullable NSString*)num//手机号
       withCountryCode:(nullable NSString*)cCode//国码,中国为 86,不要写成+86
          withPassword:(nullable NSString*)pwd//密码,需要32位的md5加密处理,如果提供明文密码,内部会自动加密
             withRePwd:(nullable NSString*)rePwd//再次密码
           withSmsCode:(nullable NSString*)smsCode;//短信验证码
-(nullable NSDictionary*)gtRegPhoneResult;//获取服务器返回的Json数据,如果有的话
#pragma mark - 手机找回的时候不要用这个方法
#pragma mark 发验证码
-(void)sendSmsWithCountryCode:(nullable NSString*)code//国码
                 withPhoneNum:(nullable NSString*)num;//手机号
-(nullable NSDictionary*)gtSendSmsResult;//获取服务器返回的Json数据,如果有的话
#pragma mark 验证验证码
-(void)checkSmsWithCountryCode:(nullable NSString*)code//国码
                  withPhoneNum:(nullable NSString*)num//手机号
                withVerifyCode:(nullable NSString*)vCode;//短信验证码
-(nullable NSDictionary*)gtCheckSmsResult;//获取服务器返回的Json数据,如果有的话
#pragma mark - 通过邮箱找回
-(void)findFromEmailWithEmail:(nullable NSString*)email;//会向这个邮箱发一封找回的邮件,仅此而已
-(nullable NSDictionary*)gtFindFromEmailResult;//获取服务器返回的Json数据,如果有的话

#pragma mark - 通过手机找回来重置密码必需严格按顺序按照下面3步执行,过程中会用到2个不同的vKey,都是由服务器返回
#pragma mark 1.通过手机找回,服务器会自动发验证码,不需要调用上面发验证码的方法
-(void)findFromPhoneWithCountryCode:(nullable NSString*)countryCode//国码,中国为 86,不要写成+86
                       withPhoneNum:(nullable NSString*)num;//手机号
-(nullable NSDictionary*)gtFindFromPhoneResult;//获取服务器返回的Json数据,如果有的话
#pragma mark 2.验证手机找回,用这个方法来验证刚才通过找回的验证码是否正确
-(void)checkFindFromPhoneWithID:(nullable NSString*)theId//这个应该从返回的json里获取
                       withVkey:(nullable NSString*)vKey//这个应该从返回的json里获取
                withCountryCode:(nullable NSString*)cCode//国码
                   withPhoneNum:(nullable NSString*)num//手机号
                    withSmsCode:(nullable NSString*)smsCode;//短信验证码
-(nullable NSDictionary*)gtCheckFindFromPhoneResult;//获取服务器返回的Json数据,如果有的话
#pragma mark 3.通过手机重置密码
-(void)reSetPasswordWithId:(nullable NSString*)theId//这个应该从返回的json里获取
                  withVkey:(nullable NSString*)vkey//这个应该从返回的json里获取
                withNewPwd:(nullable NSString*)pwd//密码,需要32位的md5加密处理,如果提供明文密码,内部会自动加密
                 withRePwd:(nullable NSString*)rePwd;//再次密码
-(nullable NSDictionary*)gtReSetPasswordResult;//获取服务器返回的Json数据,如果有的话
#pragma mark - 检查账号是否存在
-(void)checkAccountIsExistWithAccount:(nullable NSString*)account;//账号可以是邮箱或者手机
-(nullable NSDictionary *)gtAccountIsExistResult;//获取服务器返回的Json数据,如果有的话

#pragma mark - 获取账户信息
-(void)gtUserInfoWithUserID:(nullable NSString*)userID//这个应该从登录时返回的json里获取
              withSessionID:(nullable NSString*)sessionID;//这个应该从登录时返回的json里获取
-(nullable NSDictionary*)gtReadUserInfoResult;//获取服务器返回的Json数据,如果有的话,用read是不想和get这个词产生冲突

#pragma mark 设置账户信息,用于绑定邮箱和手机号
-(void)stUserInfoWithUserID:(nullable NSString*)userID//这个应该从登录时返回的json里获取
              withSessionID:(nullable NSString*)sessionID//这个应该从登录时返回的json里获取
                  withEmail:(nullable NSString*)email//绑定邮箱,此参数当bFlag=2或者0时有效,为空则解除绑定邮箱
            withCountryCode:(nullable NSString*)cCode//国码,此参数当bFlag=1或者0时有效,为空则解除绑定手机
               withPhoneNum:(nullable NSString*)phone//手机号,此参数当bFlag=1或者0时有效,为空则解除绑定手机,绑定的手机应该是未被注册过的手机
                withUserPwd:(nullable NSString*)Pwd//绑定邮箱或者手机需要验证密码,需要32位的md5加密处理,如果提供明文密码,内部会自动加密
               withBindFlag:(nullable NSString*)bFlag//绑定标志(0:同时绑定手机和邮箱 1:仅绑定手机 2:仅绑定邮箱) 不可空
                    withSms:(nullable NSString*)sms;//当绑定手机的时候需要提供手机验证码,可以调发验证码的接口就行了
-(nullable NSDictionary*)gtWriteUserInfoResult;//获取服务器返回的Json数据,如果有的话,用write是不想和set这个词产生冲突

#pragma mark - 修改用户账号密码
-(void)changeUserPasswordWithUserID:(nullable NSString*)userID//用户iD
                      withSessionID:(nullable NSString*)sessionID//会话ID
                         withOldPwd:(nullable NSString*)oldPwd//账号的原密码,需要32位的md5加密处理,如果提供明文密码,内部会自动加密
                            withPwd:(nullable NSString*)pwd//账号的新密码,需要32位的md5加密处理,如果提供明文密码,内部会自动加密
                          withRePwd:(nullable NSString*)rePwd;//两次确认的新密码,需要32位的md5加密处理,如果提供明文密码,内部会自动加密
-(nullable NSDictionary*)gtChangeUserPasswordResult;//获取服务器返回的Json数据,如果有的话

@end
@protocol GWNetDelegate <NSObject>
@optional
#pragma mark - 代理回调看这里
/**>>>>>>>>>>>>>>>>>>>>>> 看这里  <<<<<<<<<<<<<<<<<<<<
在End回调里的success仅代表网络请求是否成功,不代表相应的操作结果,具体的要从errorCode判断
所有的回调全部在UI主线程回调,要特别注意
*******************/
#pragma mark 登录
-(void)gwNet:(nullable GWNet*)gwnet loginWillStart:(BOOL)success;//将要开始
-(void)gwNet:(nullable GWNet*)gwnet loginEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;//结束

#pragma mark 第三方登录
-(void)gwNet:(nullable GWNet*)gwnet thirdLoginWillStart:(BOOL)success;
-(void)gwNet:(nullable GWNet*)gwnet thirdLoginEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;

#pragma mark 退出登录
-(void)gwNet:(nullable GWNet*)gwnet unLoginWillStart:(BOOL)success;
-(void)gwNet:(nullable GWNet*)gwnet unLoginEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;

#pragma mark 邮箱注册
-(void)gwNet:(nullable GWNet*)gwnet regEmailWillStart:(BOOL)success;
-(void)gwNet:(nullable GWNet*)gwnet regEmailEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;

#pragma mark 手机号注册
-(void)gwNet:(nullable GWNet*)gwnet regPhoneWillStart:(BOOL)success;
-(void)gwNet:(nullable GWNet*)gwnet regPhoneEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;

#pragma mark 发验证码
-(void)gwNet:(nullable GWNet*)gwnet sendSmsWillStart:(BOOL)success;
-(void)gwNet:(nullable GWNet*)gwnet sendSmsEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;

#pragma mark 验证验证码
-(void)gwNet:(nullable GWNet*)gwnet checkSmsWillStart:(BOOL)success;
-(void)gwNet:(nullable GWNet*)gwnet checkSmsEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;

#pragma mark 通过邮箱找回
-(void)gwNet:(nullable GWNet*)gwnet findFromEmailWillStart:(BOOL)success;
-(void)gwNet:(nullable GWNet*)gwnet findFromEmailEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;

#pragma mark 通过手机找回
-(void)gwNet:(nullable GWNet*)gwnet findFromPhoneWillStart:(BOOL)success;
-(void)gwNet:(nullable GWNet*)gwnet findFromPhoneEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;

#pragma mark 验证手机找回
-(void)gwNet:(nullable GWNet*)gwnet checkFindFromPhoneWillStart:(BOOL)success;
-(void)gwNet:(nullable GWNet*)gwnet checkFindFromPhoneEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;

#pragma mark 通过手机重置密码
-(void)gwNet:(nullable GWNet*)gwnet reSetPasswordWillStart:(BOOL)success;
-(void)gwNet:(nullable GWNet*)gwnet reSetPasswordEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;

#pragma mark 检查账号是否存在
-(void)gwNet:(nullable GWNet*)gwnet checkAccountIsExistWillStart:(BOOL)success;
-(void)gwNet:(nullable GWNet*)gwnet checkAccountIsExistEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;

#pragma mark 获取账户信息
-(void)gwNet:(nullable GWNet*)gwnet readUserInfoWillStart:(BOOL)success;//用read是不想和get这个词产生冲突
-(void)gwNet:(nullable GWNet*)gwnet readUserInfoEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;

#pragma mark 设置账户信息
-(void)gwNet:(nullable GWNet*)gwnet writeUserInfoWillStart:(BOOL)success;//用write是不想和set这个词产生冲突
-(void)gwNet:(nullable GWNet*)gwnet writeUserInfoEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;

#pragma mark - 修改用户账号密码
-(void)gwNet:(nullable GWNet*)gwnet changeUserPasswordWillStart:(BOOL)success;
-(void)gwNet:(nullable GWNet*)gwnet changeUserPasswordEnd:(BOOL)success withErrorCode:(nullable NSString*)errorCode withErrorString:(nullable NSString*)errorString withJson:(nullable NSDictionary*)json;
@end
