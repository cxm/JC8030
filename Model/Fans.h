//
//  Fans.h
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fans : NSObject
@property(nonatomic,strong) NSNumber *ID;
@property(nonatomic,strong) NSNumber *binID;
@property(nonatomic,copy) NSString *fanName;
@property(nonatomic,strong)NSNumber *fanNumber;
@property(nonatomic,copy)NSString *createdAt;
@property(nonatomic,copy)NSString *updatedAt;
@property(nonatomic,strong)NSNumber *removed;
@property(nonatomic,copy)NSString *status;

-(Fans *)initWithID:(NSNumber *)ID binID:(NSNumber *)binID fanName:(NSString *)fanName fanNumber:(NSNumber *)fanNumber createdAt:(NSString *)createdAt updatedAt:(NSString *)updatedAt removed:(NSNumber *)removed;

-(Fans *)initWithDictionary:(NSDictionary *)dic;

+(Fans *)FanWithID:(NSNumber *)ID binID:(NSNumber *)binID fanName:(NSString *)fanName fanNumber:(NSNumber *)fanNumber createdAt:(NSString *)createdAt updatedAt:(NSString *)updatedAt removed:(NSNumber *)removed;
@end
