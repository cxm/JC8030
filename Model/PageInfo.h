//
//  PageInfo.h
//  JC8030
//
//  Created by cxm on 16/6/16.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseInfo.h"
#import <UIKit/UIKit.h>

@interface PageInfo : BaseInfo
@property(nonatomic,strong) NSString *image;
@property(nonatomic,strong) NSString *selectedImage;

+ (NSArray *) pageControllers:(NSString *)config;
@end
