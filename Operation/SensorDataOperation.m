//
//  SensorDataOperation.m
//  JC8030
//
//  Created by cxm on 16/7/10.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "SensorDataOperation.h"
#import "DbManager.h"
@implementation SensorDataOperation
singleton_implementation(SensorDataOperation)
-(BOOL)addSenorData:(SensorData *)sensorData{
    NSString *sql=[NSString stringWithFormat:@"insert into SensorData (gatherTime,binID,cableType,cableNumber,temp,hum) values (?,?,?,?,?,?)"];
    NSArray *arguments=@[sensorData.gatherTime,sensorData.binID,sensorData.cableType,sensorData.cableNumber,sensorData.temp,sensorData.hum];
    return [[DbManager sharedDbManager] executeNonQuery:sql withArguments:arguments];
}

-(NSArray *)getLastRecordByBinID:(NSNumber *)binID gatherTime:(NSString *)gatherTime{
    NSMutableArray *sensorDatas=[[NSMutableArray alloc]init];
    NSString *sql=[NSString stringWithFormat:@"select * from SensorData where binID=? and cableType<>'O' and  gatherTime=? order by cableNumber asc"];
    NSArray *arguments=@[binID,gatherTime];
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:arguments];
    if (rows&&rows.count>0) {
        for(NSDictionary *dic in rows){
            SensorData *data=[[SensorData alloc]initWithDictionary:dic];
            [sensorDatas addObject:data];
        }
    }
    return sensorDatas;

}

-(SensorData *)getlastAmbient:(NSNumber *)binID cableType:(NSString *)cableType gatherTime:(NSString *)gatherTime{
    SensorData *sensorData=[[SensorData alloc]init];
    NSString *sql=[NSString stringWithFormat:@"select * from SensorData where binID=? and cableType=? and  gatherTime=?"];
    NSArray *arguments=@[binID,cableType,gatherTime];
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:arguments];
    if (rows&&rows.count>0) {
        [sensorData setValuesForKeysWithDictionary:rows[0]];
    }
    return sensorData;
}
-(NSArray *)getRecords:(NSNumber *)binID cableType:(NSString *)cableType cableNumber:(NSNumber *)cableNumber start:(NSString *)start end:(NSString *)end{
    NSMutableArray *amients=[[NSMutableArray alloc]init];
    return amients;
}

-(NSArray *)getAmbients:(NSNumber *)binID cableType:(NSString *)cableType start:(NSString *)start end:(NSString *)end{
    NSMutableArray *amients=[[NSMutableArray alloc]init];
    return amients;
}
@end
