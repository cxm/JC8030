//
//  Cable.m
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "Cable.h"

@implementation Cable

-(Cable *)initWithID:(NSNumber *)ID binID:(NSNumber *)binID cableNumber:(NSNumber *)cableNumber cableType:(NSString *)cableType createdAt:(NSString *)createdAt sensorCounts:(NSNumber *)sensorCounts mCounts:(NSNumber *)mCounts radius:(NSNumber *)radius rotation:(NSNumber *)rotation removed:(NSNumber *)removed sensorSpacing:(NSNumber *)sensorSpacing updatedAt:(NSString *)updatedAt{
    if(self=[super init]){
        self.ID=ID;
        self.binID=binID;
        self.cableNumber=cableNumber;
        self.cableType=cableType;
        self.createdAt=createdAt;
        self.sensorCounts=sensorCounts;
        self.mCounts=mCounts;
        self.radius=radius;
        self.rotation=rotation;
        self.removed=removed;
        self.sensorSpacing=sensorSpacing;
        self.updatedAt=updatedAt;
    }
    return  self;
}

-(Cable *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


+(Cable *)cableWithID:(NSNumber *)ID binID:(NSNumber *)binID cableNumber:(NSNumber *)cableNumber cableType:(NSString *)cableType createdAt:(NSString *)createdAt sensorCounts:(NSNumber *)sensorCounts mCounts:(NSNumber *)mCounts radius:(NSNumber *)radius rotation:(NSNumber *)rotation removed:(NSNumber *)removed sensorSpacing:(NSNumber *)sensorSpacing updatedAt:(NSString *)updatedAt{
    Cable *cable=[[Cable alloc]initWithID:ID binID:binID cableNumber:cableNumber cableType:cableType createdAt:createdAt sensorCounts:sensorCounts mCounts:mCounts radius:radius rotation:rotation removed:removed sensorSpacing:sensorSpacing updatedAt:updatedAt];
    return cable;
}

@end
