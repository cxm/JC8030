//
//  Fans.m
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "Fans.h"

@implementation Fans

-(Fans *)initWithID:(NSNumber *)ID binID:(NSNumber *)binID fanName:(NSString *)fanName fanNumber:(NSNumber *)fanNumber createdAt:(NSString *)createdAt updatedAt:(NSString *)updatedAt removed:(NSNumber *)removed{
    if(self=[super init]){
        self.ID=ID;
        self.binID=binID;
        self.fanName=fanName;
        self.fanNumber=fanNumber;
        self.createdAt=createdAt;
        self.updatedAt=updatedAt;
        self.removed=removed;
    }
    return  self;
}

-(Fans *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(Fans *)FanWithID:(NSNumber *)ID binID:(NSNumber *)binID fanName:(NSString *)fanName fanNumber:(NSNumber *)fanNumber createdAt:(NSString *)createdAt updatedAt:(NSString *)updatedAt removed:(NSNumber *)removed{
    Fans *fan=[[Fans alloc]initWithID:ID binID:binID fanName:fanName fanNumber:fanNumber createdAt:createdAt updatedAt:updatedAt removed:removed];
    return fan;
}
@end
