//
//  BaseInfo.h
//  JC8030
//
//  Created by cxm on 16/6/16.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseInfo : NSObject
@property(nonatomic,strong) NSString *ID;
@property(nonatomic,strong) NSString *name;

+(instancetype) infoFromDict:(NSDictionary *)dict;
//+(NSArray *) arrayFromDict:(NSDictionary *)dict;
+(NSArray *) arrayFromArray:(NSArray *) array;
@end
