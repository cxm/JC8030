//
//  Dbmanager.m
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "Dbmanager.h"
#import <sqlite3.h>
#import "Singleton.h"
#import "Define.h"
#import "FMDB.h"

#ifndef kDatabaseName

#define kDatabaseName @"grain.db"

#endif

@implementation DbManager

singleton_implementation(DbManager)

#pragma mark 重写初始化方法
-(instancetype)init{
    DbManager *manager;
    if((manager=[super init]))
    {
        [manager openDb:DatabaseName];
    }
    return manager;
}

-(void)openDb:(NSString *)dbname{
    //取得数据库保存路径，通常保存沙盒Documents目录
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //NSLog(@"%@",directory);
    NSString *filePath=[directory stringByAppendingPathComponent:dbname];
    //创建FMDatabaseQueue对象
    self.database=[FMDatabaseQueue databaseQueueWithPath:filePath];
}

-(BOOL)executeNonQuery:(NSString *)sql withArguments:(NSArray *)arguments{
    __block bool result;
    //执行更新sql语句，用于插入、修改、删除
    [self.database inDatabase:^(FMDatabase *db) {
        result=[db executeUpdate:sql withArgumentsInArray:arguments];
    }];
    return result;
}

-(NSArray *)executeQuery:(NSString *)sql withArguments:(NSArray *)arguments{
    NSMutableArray *array=[NSMutableArray array];
    [self.database inDatabase:^(FMDatabase *db) {
        //执行查询sql语句
        FMResultSet *result= [db executeQuery:sql withArgumentsInArray:arguments];
        while (result.next) {
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            for (int i=0; i<result.columnCount; ++i) {
                if([[result columnNameForIndex:i] isEqualToString:@"binImage"]){
                    dic[[result columnNameForIndex:i]]=[result dataForColumnIndex:i];
                    //NSLog(@"sdklfjkl");
                }
                else
                    dic[[result columnNameForIndex:i]]=[result stringForColumnIndex:i];
            }
            
            [array addObject:dic];
        }
    }];
    return array;
}
@end
