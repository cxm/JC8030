//
//  SensorData.m
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "SensorData.h"

@implementation SensorData
-(SensorData *)initWithID:(NSNumber *)ID gatherTime:(NSString *)gatherTime binID:(NSNumber *)binID cableType:(NSString *)cableType cableNumber:(NSNumber *)cableNumber temp:(NSString *)temp hum:(NSString *)hum{
    if(self=[super init]){
        self.ID=ID;
        self.gatherTime=gatherTime;
        self.binID=binID;
        self.cableType=cableType;
        self.cableNumber=cableNumber;
        self.temp=temp;
        self.hum=hum;
    }
    return self;
}

-(SensorData *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(SensorData *)sensorDataWithID:(NSNumber *)ID gatherTime:(NSString *)gatherTime binID:(NSNumber *)binID cableType:(NSString *)cableType cableNumber:(NSNumber *)cableNumber temp:(NSString *)temp hum:(NSString *)hum{
    SensorData *sensorData=[[SensorData alloc]initWithID:ID gatherTime:gatherTime binID:binID cableType:cableType cableNumber:cableNumber temp:temp hum:hum];
    return sensorData;
}
@end
