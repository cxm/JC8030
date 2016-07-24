//
//  PageInfo.m
//  JC8030
//
//  Created by cxm on 16/6/16.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "PageInfo.h"

@implementation PageInfo
+ (PageInfo *)infoFromDict:(NSDictionary *)dict
{
    PageInfo *info = [[PageInfo alloc] init];
    
    info.ID = [dict objectForKey:@"ClassName"];
    info.name = [dict objectForKey:@"Title"];
    //info.image = [dict objectForKey:@"Image"];
    
    return info;
}

+ (NSArray *)pages:(NSString *)config
{
    NSString *configFile = [[NSBundle mainBundle] pathForResource:config ofType:@"plist"];
    NSArray *pageConfigs = [NSArray arrayWithContentsOfFile:configFile];
    NSMutableArray *pages = [[NSMutableArray alloc] init];
    if (pageConfigs.count <= 0) {
        
    }
    
    for (NSDictionary *dict in pageConfigs) {
        [pages addObject:[PageInfo infoFromDict:dict]];
    }
    
    return pages;
}

+ (NSArray *)pageControllers:(NSString *)config
{
    NSMutableArray *controllers = [NSMutableArray array];
    NSArray *pages = [PageInfo pages:config];
    
    UIViewController *pageController = nil;
    UINavigationController *navPage = nil;
    
    for (PageInfo *pageInfo in pages) {
        
        pageController = [[NSClassFromString(pageInfo.ID) alloc] init];
        navPage = [[UINavigationController alloc] initWithRootViewController:pageController];
        
        pageController.title = pageInfo.name;
        //pageController.tabBarItem.image = [UIImage imageNamed:pageInfo.image];
        
        [controllers addObject:pageController];
    }
    
    return controllers;
}
@end
