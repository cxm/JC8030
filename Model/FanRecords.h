//
//  FanRecords.h
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FanRecords : NSObject{
    
}
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSNumber *fanID;
@property(nonatomic,copy)NSString *gatherTime;
@property(nonatomic,copy)NSString *operation;
@property(nonatomic,strong)NSNumber *runTime;

-(FanRecords *)initWithID:(NSNumber *)ID fanID:(NSNumber *)fanID gatherTime:(NSString *)gatherTime operation:(NSString *)opeartion runTime:(NSNumber *)runTime;
-(FanRecords *)initWithDictionary:(NSDictionary *)dic;
+(FanRecords *)recordsWithID:(NSNumber *)ID fanID:(NSNumber *)fanID gatherTime:(NSString *)gatherTime operation:(NSString *)opeartion runTime:(NSNumber *)runTime;
@end
