//
//  Bin.m
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "Bin.h"

@implementation Bin

-(Bin *)initWithID:(NSNumber *)ID binType:(NSString *)binType binName:(NSString *)binName stationID:(NSNumber *)stationID grainType:(NSString *)grainType level:(NSNumber *)level bushels:(NSNumber *)bushels totalCapacity:(NSNumber *)totalCapacity fillDate:(NSString *)fillDate createdAt:(NSString *)createdAt updatedAt:(NSString *)updatedAt removed:(NSNumber *)removed binImage:(NSData *)binImage{
    if(self=[super init]){
        self.ID=ID;
        self.binType=binType;
        self.binName=binName;
        self.stationID=stationID;
        self.grainType=grainType;
        self.level=level;
        self.bushels=bushels;
        self.totalCapacity=totalCapacity;
        self.fillDate=fillDate;
        self.createdAt=createdAt;
        self.updatedAt=updatedAt;
        self.removed=removed;
        self.binImage=binImage;
    }
    return self;
}

-(Bin *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(Bin *)binWithID:(NSNumber *)ID binType:(NSString *)binType binName:(NSString *)binName stationID:(NSNumber *)stationID grainType:(NSString *)grainType level:(NSNumber *)level bushels:(NSNumber *)bushels totalCapacity:(NSNumber *)totalCapacity fillDate:(NSString *)fillDate createdAt:(NSString *)createdAt updatedAt:(NSString *)updatedAt removed:(NSNumber *)removed binImage:(NSData *)binImage{
    Bin * bin=[[Bin alloc]initWithID:ID binType:binType binName:binName stationID:stationID grainType:grainType level:level bushels:bushels totalCapacity:totalCapacity fillDate:fillDate createdAt:createdAt updatedAt:updatedAt removed:removed binImage:binImage];
    return bin;
}
@end

