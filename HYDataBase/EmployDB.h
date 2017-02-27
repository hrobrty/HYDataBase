//
//  EmployDB.h
//  HYDataBase
//
//  Created by shideasn on 17/2/27.
//  Copyright © 2017年 hrobrty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBConnect.h"

@interface EmployDB : NSObject

/// 通过单例的方式
+ (EmployDB *)shareConnect;
-(void)newDBConnect;
//创建所有的表
-(void)CreateAll;

//拨号历史记录
-(NSArray *)SelectHistory;
-(NSInteger)InsertHistory:(NSString *) callTime diaplsyName:(NSString *) diaplsyName time:(NSString *) time sipUri:(NSString *) sipUri sipNum:(NSString *) sipNum direction:(NSInteger) direction;
-(void)DelHistory:(NSInteger) index;
-(void)UpdateHistory:(NSInteger ) hid readState:(NSInteger) readState time:(NSString *)time;
-(void)UpdateHistory:(NSInteger ) hid time:(NSString *)time;


@end
