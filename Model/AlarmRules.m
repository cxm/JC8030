//
//  AlarmRules.m
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "AlarmRules.h"

@implementation AlarmRules

-(AlarmRules *)initWithID:(NSNumber *)ID binID:(NSNumber *)binID ruleType:(NSString *)ruleType value:(NSNumber *)value{
    if(self=[super init]){
        self.ID=ID;
        self.binID=binID;
        self.ruleType=ruleType;
        self.value=value;
    }
    return self;
}

-(AlarmRules *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(AlarmRules *)AlarmRulesWithID:(NSNumber *)ID binID:(NSNumber *)binID ruleType:(NSString *)ruleType value:(NSNumber *)value{
    AlarmRules *alarm=[[AlarmRules alloc]initWithID:ID binID:binID ruleType:ruleType value:value];
    return alarm;
}
@end
