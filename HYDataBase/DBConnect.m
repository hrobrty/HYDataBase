//
//  DBConnect.h
//  HYDataBase
//
//  Created by shideasn on 17/2/27.
//  Copyright © 2017年 hrobrty. All rights reserved.
//
#define HYDataBase  @"HYDataBase.sqlite"
#import "DBConnect.h"

//#define NAME @"WanShiTongDB"
//#define SQLNAME @"1004_WanShiTongDB.sqlite"

@implementation DBConnect{
    NSString *NAMESQL;
}

static DBConnect *dBHandle;

+ (DBConnect *)shareConnect
{
    if (dBHandle == nil) {
        dBHandle = [[DBConnect alloc] init];
        [dBHandle openDatabase];
    }
    return dBHandle;
}

/// 打开数据库
- (void)openDatabase
{
    //也可以传值进来，自动创建数据库名
   // UserModel *model = [StorageTools getUserModel];
    // NAMESQL = model.account;
    
    NSString *sqlPath = [[self getDocumentPath] stringByAppendingPathComponent:HYDataBase]; //NAMESQL
    self.dataBase = [FMDatabase databaseWithPath:sqlPath];
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:sqlPath];
    [_dataBase open];
    if (![_dataBase open]) {
        NSLog(@"数据库打开失败");
    }else{
        NSLog(@"数据库打开成功");
    }
}

/// 获得document文件的路径
- (NSString *)getDocumentPath
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject]; // 获取document文件的路径
    
    return documentPath;
}

/// 判断是否存在表
- (BOOL)isTableOK:(NSString *)tableName
{
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) as 'count' FROM sqlite_master WHERE type ='table' and name = '%@'", tableName];
    int count = [self getDBDataCount:sql];
    if (count > 0) {
        return YES;
    }
    
    return NO;
}

/// 创建表
- (BOOL)createTableSql:(NSString *)sql
{
    [self executeInsertSql:sql];
    
    return YES;
}

/// 获得数据
- (NSArray *)getDBlist:(NSString *)sql
{
    __block NSMutableArray *list = [[NSMutableArray alloc] init];
    NSLog(@"%@", sql);
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeStatements:sql withResultBlock:^int(NSDictionary *dictionary) {
            
            [list addObject:dictionary];
            
            return 0;
        }];
        [self closeDatabase];
    }];
    
    return list;
}

/// 获得单条数据
- (NSDictionary *)getDBOneData:(NSString *)sql
{
    __block NSMutableArray *list = [[NSMutableArray alloc] init];
    NSLog(@"%@", sql);
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeStatements:sql withResultBlock:^int(NSDictionary *dictionary) {
            
            [list addObject:dictionary];
            
            return 0;
        }];
        
    }];
    
    if (list.count == 1) {
        return [list objectAtIndex:0];
    }
    
    return nil;
}

/// 统计数量
- (int)getDBDataCount:(NSString *)sql
{
    int count = 0;
    __block NSMutableArray *list = [[NSMutableArray alloc] init];
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [db executeStatements:sql withResultBlock:^int(NSDictionary *dictionary) {
            
            [list addObject:dictionary];
            
            return 0;
        }];
        
    }];
    
    if (list.count == 1) {
        NSDictionary *dict = [list objectAtIndex:0];
        if (dict) {
            count = [[dict objectForKey:@"count"] intValue];
        }
    }
    NSLog(@"getDBDataCount count===%d", count);
    
    return count;
}

/// 执行sql (主要用来执行插入操作)
- (unsigned)executeInsertSql:(NSString *)sql
{
    __block unsigned mid = 0;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSLog(@"%@", sql);
        BOOL success = [db executeStatements:sql];
        NSLog(@"sql语句执行成功 %d", success);
        mid = (unsigned)[db lastInsertRowId];
        [self closeDatabase];
    }];
    
    return mid;
}

/// 更新操作，删除操作
- (void)executeUpdateSql:(NSString *)sql
{
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSLog(@"%@", sql);
        BOOL success = [db executeStatements:sql];
        NSLog(@"sql语句执行成功 %d", success);
        [self closeDatabase];
    }];
}

/// 关闭数据库
- (void)closeDatabase
{
    [self.dataBase close];
}

-(void)newDBConnect{
    dBHandle = nil;
}

@end
