//
//  BaseObj.m
//  GWNetDemo
//
//  Created by apple on 17/2/21.
//  Copyright © 2017年 YuanHongQiang. All rights reserved.
//

#import "BaseObj.h"

@implementation BaseObj
+(UIButton*)gtBaseButtonWithTitle:(NSString*)title{
    UIButton* button=[[UIButton alloc] initWithFrame:CGRectMake(10, 70, 100, 30)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"bt1.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"bt2.png"] forState:UIControlStateHighlighted];
    return button;
}
@end
