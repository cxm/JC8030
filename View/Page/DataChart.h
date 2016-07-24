//
//  DataChart.h
//  JC8030
//
//  Created by cxm on 16/7/9.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"

@interface DataChart : BaseConroller
@property(nonatomic,copy)NSString *dataType;
@property(nonatomic,copy)NSString *gatherTime;
-(void)updateData;
@end
