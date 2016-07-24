//
//  AlarmRules.h
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmRules : NSObject
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSNumber *binID;
@property(nonatomic,copy)NSString *ruleType;
@property(nonatomic,strong)NSNumber *value;

-(AlarmRules *)initWithID:(NSNumber *)ID binID:(NSNumber *)binID ruleType:(NSString *)ruleType value:(NSNumber *)value;

-(AlarmRules *)initWithDictionary:(NSDictionary *)dic;

+(AlarmRules *)AlarmRulesWithID:(NSNumber *)ID binID:(NSNumber *)binID ruleType:(NSString *)ruleType value:(NSNumber *)value;
@end
