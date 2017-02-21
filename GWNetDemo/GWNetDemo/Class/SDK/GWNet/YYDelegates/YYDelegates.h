//
//  YYDelegates.h
//  YYNetCheck
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YYDelegate : NSObject
@property(nonatomic,weak,nullable)id delegate;
@end
@interface YYDelegates : NSObject
-(nullable NSArray<YYDelegate*>*)gtAllDelegates;//获取所有代理
-(void)addTheDelegate:(nullable id)delegate;//添加代理,重复的不会添加
-(void)deleteTheDelegate:(nullable id)delegate;//删除代理
-(void)deleteAllTheDelegate;//删除所有代理
@end
