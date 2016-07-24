//
//  SensorDataOperation.h
//  JC8030
//
//  Created by cxm on 16/7/10.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "SensorData.h"
@interface SensorDataOperation : NSObject
singleton_interface(SensorDataOperation)
-(BOOL)addSenorData:(SensorData *)sensorData;
-(NSArray *)getLastRecordByBinID:(NSNumber *)binID gatherTime:(NSString *)gatherTime;
-(SensorData *)getlastAmbient:(NSNumber *)binID cableType:(NSString *)cableType gatherTime:(NSString *)gatherTime;
-(NSArray *)getAmbients:(NSNumber *)binID cableType:(NSString *)cableType start:(NSString *)start end:(NSString *)end;
-(NSArray *)getRecords:(NSNumber *)binID cableType:(NSString *)cableType cableNumber:(NSNumber *)cableNumber start:(NSString *)start end:(NSString *)end;
@end
