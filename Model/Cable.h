//
//  Cable.h
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cable : NSObject

@property (nonatomic,strong) NSNumber *ID;
@property (nonatomic,strong) NSNumber *binID;
@property (nonatomic,strong) NSNumber *cableNumber;
@property (nonatomic,copy) NSString *cableType;
@property (nonatomic,copy) NSString *createdAt;
@property (nonatomic,strong) NSNumber *sensorCounts;
@property (nonatomic,strong) NSNumber *mCounts;
@property (nonatomic,strong) NSNumber *radius;
@property (nonatomic,strong) NSNumber *rotation;
@property (nonatomic,strong) NSNumber *removed;
@property (nonatomic,strong) NSNumber *sensorSpacing;
@property (nonatomic,copy) NSString *updatedAt;

-(Cable *)initWithID:(NSNumber *)ID binID:(NSNumber *)binID cableNumber:(NSNumber *)cableNumber cableType:(NSString *)cableType createdAt:(NSString *)createdAt sensorCounts:(NSNumber *)sensorCounts mCounts:(NSNumber *)mCounts radius:(NSNumber *)radius rotation:(NSNumber *)rotation removed:(NSNumber *)removed sensorSpacing:(NSNumber *)sensorSpacing updatedAt:(NSString *)updatedAt;

-(Cable *)initWithDictionary:(NSDictionary *)dic;

+(Cable *)cableWithID:(NSNumber *)ID binID:(NSNumber *)binID cableNumber:(NSNumber *)cableNumber cableType:(NSString *)cableType createdAt:(NSString *)createdAt sensorCounts:(NSNumber *)sensorCounts mCounts:(NSNumber *)mCounts radius:(NSNumber *)radius rotation:(NSNumber *)rotation removed:(NSNumber *)removed sensorSpacing:(NSNumber *)sensorSpacing updatedAt:(NSString *)updatedAt;

@end
