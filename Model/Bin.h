//
//  Bin.h
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bin : NSObject

@property (nonatomic,strong) NSNumber *ID;

@property (nonatomic,copy) NSString *binType;
@property (nonatomic,copy) NSString *binName;
@property (nonatomic,strong) NSNumber *stationID;
@property (nonatomic,copy) NSString *grainType;
@property (nonatomic,strong) NSNumber *level;
@property (nonatomic,strong) NSNumber *bushels;
@property (nonatomic,strong) NSNumber *totalCapacity;
@property (nonatomic,copy) NSString *fillDate;
@property (nonatomic,strong) NSString *createdAt;
@property (nonatomic,strong) NSString *updatedAt;
@property (nonatomic,strong) NSNumber *removed;
@property (nonatomic,strong)  NSData *binImage;

-(Bin *)initWithID:(NSNumber *)ID binType:(NSString *)binType binName:(NSString *)binName stationID:(NSNumber *)stationID grainType:(NSString *)grainType level:(NSNumber *)level bushels:(NSNumber *)bushels totalCapacity:(NSNumber *)totalCapacity fillDate:(NSString *)fillDate createdAt:(NSString *)createdAt updatedAt:(NSString *)updatedAt removed:(NSNumber *)removed binImage:(NSData *)binImage;

-(Bin *)initWithDictionary:(NSDictionary *)dic;

+(Bin *)binWithID:(NSNumber *)ID binType:(NSString *)binType binName:(NSString *)binName stationID:(NSNumber *)stationID grainType:(NSString *)grainType level:(NSNumber *)level bushels:(NSNumber *)bushels totalCapacity:(NSNumber *)totalCapacity fillDate:(NSString *)fillDate createdAt:(NSString *)createdAt updatedAt:(NSString *)updatedAt removed:(NSNumber *)removed binImage:(NSData *)binImage;
@end
