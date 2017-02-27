///
//  EmployDB.h
//  HYDataBase
//
//  Created by shideasn on 17/2/27.
//  Copyright © 2017年 hrobrty. All rights reserved.
//

#import "EmployDB.h"

@implementation EmployDB

static EmployDB *emDB;

+ (EmployDB *)shareConnect
{
    if (emDB == nil) {
        emDB = [[EmployDB alloc] init];
    }
    return emDB;
}

-(void)newDBConnect{
    [[DBConnect shareConnect] newDBConnect];
    [self CreateAll];
}

//创建一个名为：History 的表格
-(void)CreateAll{
    if (![[DBConnect shareConnect] isTableOK:@"History"]) {
        [self CreateHistory];
    }
}

-(BOOL)CreateHistory{
    NSString *sql = @"create table History(id INTEGER PRIMARY KEY,callTime VARCHAR(40),diaplsyName VARCHAR(20),time VARCHAR(40),sipUri VARCHAR(255),sipNum VARCHAR(20),direction INTEGER)";
    return [[DBConnect shareConnect] createTableSql:sql];
}
// 拿出表格中数据
-(NSArray *)SelectHistory{
    NSString *sql = @"SELECT * FROM History ORDER BY callTime DESC";
    NSArray *arr = [[DBConnect shareConnect] getDBlist:sql];
    return arr;
}
//记录一项操作的数据，需要的数据自己可以更改
-(NSInteger)InsertHistory:(NSString *) callTime diaplsyName:(NSString *) diaplsyName time:(NSString *) time sipUri:(NSString *) sipUri sipNum:(NSString *) sipNum direction:(NSInteger) direction{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO History (callTime, diaplsyName, time, sipUri, sipNum, direction) VALUES ('%@', '%@', '%@', '%@', '%@', '%ld')",callTime,diaplsyName,time,sipUri,sipNum,(long)direction]; // 时间 ，操作ID，
    NSInteger num =  [[DBConnect shareConnect] executeInsertSql:sql];
    return num;
}
//删除表格中的某一项
-(void)DelHistory:(NSInteger) index{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM History WHERE id = %ld",index];
    [[DBConnect shareConnect] executeUpdateSql:sql];
}
//更新表格
-(void)UpdateHistory:(NSInteger ) hid readState:(NSInteger) readState time:(NSString *)time{
    NSString *sql = [NSString stringWithFormat:@"UPDATE History SET direction = '%ld',time = '%@'  WHERE id = '%ld' ",readState,time,hid];
    [[DBConnect shareConnect] executeUpdateSql:sql];
}

-(void)UpdateHistory:(NSInteger ) hid time:(NSString *)time{
    NSString *sql = [NSString stringWithFormat:@"UPDATE History SET time = '%@'  WHERE id = '%ld' ",time,hid];
    [[DBConnect shareConnect] executeUpdateSql:sql];
}




@end
