//
//  BinSum.m
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BinSum.h"

@implementation BinSum

-(BinSum *)initWithID:(NSNumber *)ID gatherTime:(NSString *)gatherTime binID:(NSNumber *)binID layer:(NSNumber *)layer maxT:(NSNumber *)maxT minT:(NSNumber *)minT avgT:(NSNumber *)avgT maxM:(NSNumber *)maxM minM:(NSNumber *)minM avgM:(NSNumber *)avgM{
    if(self=[super init]){
        self.ID=ID;
        self.gatherTime=gatherTime;
        self.binID=binID;
        self.layer=layer;
        self.maxT=maxT;
        self.minT=minT;
        self.avgT=avgT;
        self.maxM=maxM;
        self.minM=minM;
        self.avgM=avgM;
    }
    return self;
}

-(BinSum *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(BinSum *)binSumWithID:(NSNumber *)ID gatherTime:(NSString *)gatherTime binID:(NSNumber *)binID layer:(NSNumber *)layer maxT:(NSNumber *)maxT minT:(NSNumber *)minT avgT:(NSNumber *)avgT maxM:(NSNumber *)maxM minM:(NSNumber *)minM avgM:(NSNumber *)avgM{
    BinSum *binSum=[[BinSum alloc]initWithID:ID gatherTime:gatherTime binID:binID layer:layer maxT:maxT minT:minT avgT:avgT maxM:maxM minM:minM avgM:avgM];
    return binSum;
}
@end
