//
//  BinSum.h
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinSum : NSObject

@property (nonatomic,strong) NSNumber *ID;
@property (nonatomic,copy) NSString *gatherTime;
@property (nonatomic,strong) NSNumber *binID;
@property (nonatomic,strong) NSNumber *layer;
@property (nonatomic,strong) NSNumber *maxT;
@property (nonatomic,strong) NSNumber *minT;
@property (nonatomic,strong) NSNumber *avgT;
@property (nonatomic,strong) NSNumber *maxM;
@property (nonatomic,strong) NSNumber *minM;
@property (nonatomic,strong) NSNumber *avgM;

-(BinSum *)initWithID:(NSNumber *)ID gatherTime:(NSString *)gatherTime binID:(NSNumber *)binID layer:(NSNumber *)layer maxT:(NSNumber *)maxT minT:(NSNumber *)minT avgT:(NSNumber *)avgT maxM:(NSNumber *)maxM minM:(NSNumber *)minM avgM:(NSNumber *)avgM;

-(BinSum *)initWithDictionary:(NSDictionary *)dic;

+(BinSum *)binSumWithID:(NSNumber *)ID gatherTime:(NSString *)gatherTime binID:(NSNumber *)binID layer:(NSNumber *)layer maxT:(NSNumber *)maxT minT:(NSNumber *)minT avgT:(NSNumber *)avgT maxM:(NSNumber *)maxM minM:(NSNumber *)minM avgM:(NSNumber *)avgM;
@end
