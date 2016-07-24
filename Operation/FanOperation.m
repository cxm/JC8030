//
//  FanOperation.m
//  JC8030
//
//  Created by cxm on 16/7/7.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "FanOperation.h"
#import "DbManager.h"

@implementation FanOperation
singleton_implementation(FanOperation)

-(BOOL)addFan:(Fans *)fan{
    NSString *sql=[NSString stringWithFormat:@"insert into Fans (binID,fanName,fanNumber,createdAt,updatedAt,removed) values (?,?,?,?,?,?)"];
    NSArray *arguments=@[fan.binID,fan.fanName,fan.fanNumber,fan.createdAt,fan.updatedAt,fan.removed];
    return [[DbManager sharedDbManager] executeNonQuery:sql withArguments:arguments];
}

-(void)modifyFan:(Fans *)fan{
    NSString *sql=[NSString stringWithFormat:@"update Fans set binID=?,fanName=?,fanNumber=?,createdAt=?,updatedAt=?,removed=? where ID=?"];
    NSArray *arguments=@[fan.binID,fan.fanName,fan.fanNumber,fan.createdAt,fan.updatedAt,fan.removed,fan.ID];
    [[DbManager sharedDbManager] executeNonQuery:sql withArguments:arguments];
}

-(NSArray *)getFansByBinID:(NSNumber *)binID{
    NSMutableArray *fansArray=[[NSMutableArray alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM Fans WHERE binID=?"];
    NSArray *arguments=@[binID];
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:arguments];
    if (rows&&rows.count>0) {
        for(NSDictionary *dic in rows){
            Fans *fan=[[Fans alloc]init];
            [fan setValuesForKeysWithDictionary:dic];
            [fansArray addObject:fan];
        }
    }
    return fansArray;
}

-(void)initFansByBinID:(NSNumber *)binID{
    [self addFan:[Fans FanWithID:@(0) binID:binID fanName:@"Fan1" fanNumber:@(1) createdAt:[CXMGlobal getCurrentDateTime] updatedAt:[CXMGlobal getCurrentDateTime] removed:@(1)]];
    [self addFan:[Fans FanWithID:@(0) binID:binID fanName:@"Fan2" fanNumber:@(2) createdAt:[CXMGlobal getCurrentDateTime] updatedAt:[CXMGlobal getCurrentDateTime] removed:@(1)]];
    [self addFan:[Fans FanWithID:@(0) binID:binID fanName:@"Fan3" fanNumber:@(3) createdAt:[CXMGlobal getCurrentDateTime] updatedAt:[CXMGlobal getCurrentDateTime] removed:@(1)]];
    [self addFan:[Fans FanWithID:@(0) binID:binID fanName:@"Fan4" fanNumber:@(4) createdAt:[CXMGlobal getCurrentDateTime] updatedAt:[CXMGlobal getCurrentDateTime] removed:@(1)]];
}
@end
