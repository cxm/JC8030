//
//  FanRecordOperation.m
//  JC8030
//
//  Created by cxm on 16/7/12.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "FanRecordOperation.h"
#import "DbManager.h"
@implementation FanRecordOperation
singleton_implementation(FanRecordOperation)
-(BOOL)addRecord:(FanRecords *)record{
    NSString *sql=[NSString stringWithFormat:@"insert into FanRecords (fanID,gatherTime,operation,runningTime) values (?,?,?,?)"];
    NSArray *arguments=@[record.fanID,record.gatherTime,record.operation,record.runTime];
    return [[DbManager sharedDbManager] executeNonQuery:sql withArguments:arguments];
}

-(NSArray *)getAllRecord:(NSNumber *)fanID{
    NSMutableArray *records=[[NSMutableArray alloc]init];
    NSString *sql=[NSString stringWithFormat:@"select * from FanRecords where fanID=? order by gatherTime asc"];
    NSArray *arguments=@[fanID];
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:arguments];
    if (rows&&rows.count>0) {
        for(NSDictionary *dic in rows){
            FanRecords *data=[[FanRecords alloc]initWithDictionary:dic];
            [records addObject:data];
        }
    }
    return records;
}
@end
