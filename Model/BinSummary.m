//
//  BinSummary.m
//  JC8030
//
//  Created by cxm on 16/7/6.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BinSummary.h"

@implementation BinSummary

-(BinSummary *)initWithBinID:(NSNumber *)binID binType:(NSString *)binType binName:(NSString *)binName grainType:(NSString *)grainType level:(NSNumber *)level bushels:(NSNumber *)bushels binImage:(NSData *)binImage layer:(NSNumber *)layer gatherTime:(NSString *)gatherTime avgT:(NSNumber *)avgT avgM:(NSNumber *)avgM{
    if(self=[super init]){
        self.binID=binID;
        self.binType=binType;
        self.binName=binName;
        self.grainType=grainType;
        self.level=level;
        self.bushels=bushels;
        self.binImage=binImage;
        self.layer=layer;
        self.gatherTime=gatherTime;
        self.avgT=avgT;
        self.avgM=avgM;
    }
    return self;
}


+(BinSummary *)binSummaryWithBinID:(NSNumber *)binID binType:(NSString *)binType binName:(NSString *)binName grainType:(NSString *)grainType level:(NSNumber *)level bushels:(NSNumber *)bushels binImage:(NSData *)binImage layer:(NSNumber *)layer gatherTime:(NSString *)gatherTime avgT:(NSNumber *)avgT avgM:(NSNumber *)avgM{
    BinSummary *binSummary=[[BinSummary alloc]initWithBinID:binID binType:binType binName:binName grainType:grainType level:level bushels:bushels binImage:binImage layer:layer gatherTime:gatherTime avgT:avgT avgM:avgM];
    return binSummary;
}
@end
