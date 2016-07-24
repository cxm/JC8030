//
//  BaseInfo.m
//  JC8030
//
//  Created by cxm on 16/6/16.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseInfo.h"

@implementation BaseInfo

+(instancetype) infoFromDict:(NSDictionary *)dict{
    BaseInfo *info=[[BaseInfo alloc]init];
    info.ID=[dict objectForKey:@"id"];
    info.name=[dict objectForKey:@"name"];
    return info;
}


+(NSArray *)arrayFromArray:(NSArray *)array{
    NSMutableArray *infos=[[NSMutableArray alloc]init];
    for(NSDictionary *dict in array){
        [infos addObject:[[self class] infoFromDict:dict]];
    }
    if(infos.count<=0)
        infos=nil;
    return infos;
}
@end
