//
//  AlarmOperation.m
//  JC8030
//
//  Created by cxm on 16/7/7.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "AlarmOperation.h"
#import "DbManager.h"

@implementation AlarmOperation
singleton_implementation(AlarmOperation)
-(BOOL)addAlarmRule:(AlarmRules *)alarmRule{
    NSString *sql=[NSString stringWithFormat:@"insert into AlarmRules (binID,ruleType,value) values (?,?,?)"];
    NSArray *arguments=@[alarmRule.binID,alarmRule.ruleType,alarmRule.value];
    return [[DbManager sharedDbManager] executeNonQuery:sql withArguments:arguments];
}

-(void)modifAlarmRule:(AlarmRules *)alarmRule{
    NSString *sql=[NSString stringWithFormat:@"update AlarmRules set binID=?,ruleType=?,value=? where ID=?"];
    NSArray *arguments=@[alarmRule.binID,alarmRule.ruleType,alarmRule.ID];
    [[DbManager sharedDbManager] executeNonQuery:sql withArguments:arguments];
}

-(NSArray *)getAlarmRulesBybinID:(NSNumber *)binID{
    NSMutableArray *alarmsArray=[[NSMutableArray alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM AlarmRules WHERE binID=?"];
    NSArray *arguments=@[binID];
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:arguments];
    if (rows&&rows.count>0) {
        for(NSDictionary *dic in rows){
            AlarmRules *alarm=[[AlarmRules alloc]init];
            [alarm setValuesForKeysWithDictionary:dic];
            [alarmsArray addObject:alarm];
        }
    }
    return alarmsArray;
}

-(AlarmRules *)getAlarmRulesByID:(NSNumber *)ID{
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM AlarmRules WHERE ID=?"];
    NSArray *arguments=@[ID];
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:arguments];
    AlarmRules *alarm=[[AlarmRules alloc]init];
    if (rows&&rows.count>0) {
        [alarm setValuesForKeysWithDictionary:rows[0]];
    }
    return alarm;
}

-(BOOL)alarmISExist:(NSNumber *)ID{
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM AlarmRules WHERE ID=?"];
    NSArray *arguments=@[ID];
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:arguments];
    if(rows&&rows.count>0)
        return true;
    else
        return false;
}

-(void)removeAlarmByBinID:(NSNumber *)binID ruleType:(NSString *)ruleType{
    NSString *sql=[NSString stringWithFormat:@"DELETE  FROM AlarmRules WHERE BinID=? and ruleType=?"];
    NSArray *arguments=@[binID,ruleType];
    [[DbManager sharedDbManager] executeNonQuery:sql withArguments:arguments];
}


@end
