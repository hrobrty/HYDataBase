# HYDataBase
- A module, about creating the database directly, can also create multiple databases.Create table in the database, the table has add and check to change, and other functions.

- 一个在FMDB基础上写的一个模块,直接创建数据库,也可以创建多个数据库。在数据库中创建表,有增删查改等功能。

# CocoPods
- 你可以   pod  ‘HYDataBase’

# Requirements
- Object-c
- Xcode 5 or higher
- iOS 6 or higher
- ARC

# Usege Demo

* 数据库的操作：
```java 
//  DBConnect.h
//  HYDataBase
//
//  Created by shideasn on 17/2/27.
//  Copyright © 2017年 hrobrty. All rights reserved.
//

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
```

* 2对表格的操作：
```java
// 通过单例的方式
+ (EmployDB *)shareConnect;

//创建所有的表
- (void)newDBConnect;

//创建所有的表
- (void)CreateAll;

//操作历史记录
- (NSArray *)SelectHistory;

//记录一项操作的数据，需要的数据自己可以更改
- (NSInteger)InsertHistory:(NSString *) callTime diaplsyName:(NSString *) diaplsyName time:(NSString *) time sipUri:(NSString *) sipUri sipNum:(NSString *) sipNum direction:(NSInteger) direction;

//删除表格中的某一项
- (void)DelHistory:(NSInteger) index;

//更新表格
- (void)UpdateHistory:(NSInteger ) hid readState:(NSInteger) readState time:(NSString *)time;

- (void)UpdateHistory:(NSInteger ) hid time:(NSString *)time;

@end

```

# Contact
    - 如果发现bug或有值得改进的地方，please pull reqeust me.
 
# 码农其他共享代码：
    ＊ [HYHYSelectView  实用selecteview(给星星哟！)](https://github.com/hrobrty/HYDataBase.git)
