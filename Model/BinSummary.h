//
//  BinSummary.h
//  JC8030
//
//  Created by cxm on 16/7/6.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinSummary : NSObject

@property (nonatomic,strong) NSNumber *binID;
@property (nonatomic,copy) NSString *binType;
@property (nonatomic,copy) NSString *binName;
@property (nonatomic,copy) NSString *grainType;
@property (nonatomic,strong) NSNumber *level;
@property (nonatomic,strong) NSNumber *bushels;
@property (nonatomic,strong)  NSData *binImage;
@property (nonatomic,strong) NSNumber *layer;
@property (nonatomic,copy)NSString *gatherTime;
@property (nonatomic,strong) NSNumber *avgT;
@property (nonatomic,strong) NSNumber *avgM;

-(BinSummary *)initWithBinID:(NSNumber *)binID binType:(NSString *)binType binName:(NSString *)binName grainType:(NSString *)grainType level:(NSNumber *)level bushels:(NSNumber *)bushels binImage:(NSData *)binImage layer:(NSNumber *)layer gatherTime:(NSString *)gatherTime avgT:(NSNumber *)avgT avgM:(NSNumber *)avgM;


+(BinSummary *)binSummaryWithBinID:(NSNumber *)binID binType:(NSString *)binType binName:(NSString *)binName grainType:(NSString *)grainType level:(NSNumber *)level bushels:(NSNumber *)bushels binImage:(NSData *)binImage layer:(NSNumber *)layer gatherTime:(NSString *)gatherTime avgT:(NSNumber *)avgT avgM:(NSNumber *)avgM;
@end
