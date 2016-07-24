//
//  BaseConroller.h
//  JC8030
//
//  Created by cxm on 16/6/17.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BinSummary.h"
@interface BaseConroller : UIViewController
@property(nonatomic,strong) BinSummary *binSummary;
@property(nonatomic,strong)NSNumber *binID;

- (void)setNavigationTitleImage:(NSString *)imageName;
- (void)setNavigationLeft:(NSString *)imageName title:(NSString*)title sel:(SEL)sel;
- (void)setNavigationRight:(NSString *)imageName title:(NSString*)title tab:(NSString *)tab;
- (void)setStatusBarStyle:(UIStatusBarStyle)style;
-(void)setNavigationLeftOnlyBack:(NSString *)title;
@end
