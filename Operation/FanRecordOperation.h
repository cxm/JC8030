//
//  FanRecordOperation.h
//  JC8030
//
//  Created by cxm on 16/7/12.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "FanRecords.h"
@interface FanRecordOperation : NSObject
singleton_interface(FanRecordOperation)
-(BOOL)addRecord:(FanRecords *)record;
-(NSArray *)getAllRecord:(NSNumber *)fanID;
@end
