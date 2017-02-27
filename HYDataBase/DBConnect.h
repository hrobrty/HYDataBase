//
//  DBConnect.h
//  HYDataBase
//
//  Created by shideasn on 17/2/27.
//  Copyright © 2017年 hrobrty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "FMResultSet.h"
#import "HYHead.h"

@interface DBConnect : NSObject

@property (nonatomic, retain) FMDatabase *dataBase;  // 数据库类
@property (nonatomic, retain) FMDatabaseQueue *dbQueue;

/// 通过单例的方式
+ (DBConnect *)shareConnect;

/// 打开数据库
- (void)openDatabase;

/// 判断是否存在表
- (BOOL)isTableOK:(NSString *)tableName;

/// 创建表
- (BOOL)createTableSql:(NSString *)sql;

/// 获得数据
- (NSArray *)getDBlist:(NSString *)sql;

/// 获得单条数据
- (NSDictionary *)getDBOneData:(NSString *)sql;

/// 统计数量
- (int)getDBDataCount:(NSString *)sql;

/// 执行sql (主要用来执行插入操作)
- (unsigned)executeInsertSql:(NSString *)sql;

/// 更新操作，删除操作
- (void)executeUpdateSql:(NSString *)sql;

/// 关闭数据库
- (void)closeDatabase;
//重新开启新的数据库
-(void)newDBConnect;
@end
