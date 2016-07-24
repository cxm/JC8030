//
//  CableOperation.h
//  JC8030
//
//  Created by cxm on 16/7/5.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cable.h"
#import "Singleton.h"
@interface CableOperation : NSObject
singleton_interface(CableOperation)
-(BOOL)addCable:(Cable *)cable;
-(void)modifyCable:(Cable *)cable;
-(NSMutableArray *)getCablesByBinID:(NSNumber *)binID;
-(Cable *)getCableByID:(NSNumber *)ID;
-(void)removeCable:(NSNumber *)ID;
-(NSArray *)getSensorCounts:(NSNumber *)binID;
@end
