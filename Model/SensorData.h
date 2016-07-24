//
//  SensorData.h
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SensorData : NSObject
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,copy)NSString *gatherTime;
@property(nonatomic,strong)NSNumber *binID;
@property(nonatomic,copy)NSString *cableType;
@property(nonatomic,strong)NSNumber *cableNumber;
@property(nonatomic,copy)NSString *temp;
@property(nonatomic,copy)NSString *hum;

-(SensorData *)initWithID:(NSNumber *)ID gatherTime:(NSString *)gatherTime binID:(NSNumber *)binID cableType:(NSString *)cableType cableNumber:(NSNumber *)cableNumber temp:(NSString *)temp hum:(NSString *)hum;
-(SensorData *)initWithDictionary:(NSDictionary *)dic;
+(SensorData *)sensorDataWithID:(NSNumber *)ID gatherTime:(NSString *)gatherTime binID:(NSNumber *)binID cableType:(NSString *)cableType cableNumber:(NSNumber *)cableNumber temp:(NSString *)temp hum:(NSString *)hum;
@end
