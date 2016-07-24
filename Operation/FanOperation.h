//
//  FanOperation.h
//  JC8030
//
//  Created by cxm on 16/7/7.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fans.h"
#import "Singleton.h"
@interface FanOperation : NSObject
singleton_interface(FanOperation)
-(BOOL)addFan:(Fans *)fan;
-(void)modifyFan:(Fans *)fan;
-(NSArray *)getFansByBinID:(NSNumber *)binID;
-(void)initFansByBinID:(NSNumber *)binID;
@end
