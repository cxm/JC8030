//
//  BinSumOperation.h
//  JC8030
//
//  Created by cxm on 16/7/6.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinSum.h"
#import "Singleton.h"
@interface BinSumOperation : NSObject
singleton_interface(BinSumOperation)
-(BOOL)addBinSum:(BinSum *)binSum;
-(BinSum *)getLastSumByBinID:(NSNumber *)binID layer:(NSNumber *)layer;
-(NSArray *)getAllSumByBinID:(NSNumber *)binID layer:(NSNumber *)layer startDate:(NSString *)start endDate:(NSString *)end;
@end
