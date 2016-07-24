//
//  FanRecords.m
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "FanRecords.h"

@implementation FanRecords
-(FanRecords *)initWithID:(NSNumber *)ID fanID:(NSNumber *)fanID gatherTime:(NSString *)gatherTime operation:(NSString *)opeartion runTime:(NSNumber *)runTime{
    if(self=[super init]){
        self.ID=ID;
        self.fanID=fanID;
        self.gatherTime=gatherTime;
        self.operation=opeartion;
        self.runTime=runTime;
    }
    return  self;
}

-(FanRecords *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}

+(FanRecords *)recordsWithID:(NSNumber *)ID fanID:(NSNumber *)fanID gatherTime:(NSString *)gatherTime operation:(NSString *)opeartion runTime:(NSNumber *)runTime{
    FanRecords * records=[[FanRecords alloc]initWithID:ID fanID:fanID gatherTime:gatherTime operation:opeartion runTime:runTime];
    return records;
}
@end
