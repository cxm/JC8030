//
//  Dbmanager.h
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Singleton.h"
#import "FMDB.h"

@interface DbManager : NSObject

singleton_interface(DbManager);

#pragma mark - 属性
#pragma mark 数据库引用，使用它进行数据库操作
@property (nonatomic,strong) FMDatabaseQueue *database;


/**
 *  执行无返回值的sql
 *
 *  @param sql sql语句
 */
-(BOOL)executeNonQuery:(NSString *)sql withArguments:(NSArray *)arguments;

/**
 *  执行有返回值的sql
 *
 *  @param sql sql语句
 *
 *  @return 查询结果
 */
-(NSArray *)executeQuery:(NSString *)sql withArguments:(NSArray *)arguments;

@end
