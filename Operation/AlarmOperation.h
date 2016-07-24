//
//  AlarmOperation.h
//  JC8030
//
//  Created by cxm on 16/7/7.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlarmRules.h"
#import "Singleton.h"
@interface AlarmOperation : NSObject
singleton_interface(AlarmOperation)
-(BOOL)addAlarmRule:(AlarmRules *)alarmRule;
-(void)modifAlarmRule:(AlarmRules *)alarmRule;
-(NSArray *)getAlarmRulesBybinID:(NSNumber *)binID;
-(AlarmRules *)getAlarmRulesByID:(NSNumber *)ID;
-(BOOL)alarmISExist:(NSNumber *)ID;
-(void)removeAlarmByBinID:(NSNumber *)binID ruleType:(NSString *)ruleType;
@end
