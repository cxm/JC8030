//
//  GrainTypecontrollerViewController.h
//  JC8030
//
//  Created by cxm on 16/7/2.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"
#import "GrainType Table.h"
@protocol setGrainTypeDelegate<NSObject>
-(void)setGrainType:(NSString *)grainType;
@end

@protocol setGrainTypeDelegate;

@interface GrainTypeController : BaseConroller{
    IBOutlet UITableView *tableView;
}
@property(nonatomic,strong)GrainType_Table *grainTable;
@property(nonatomic,strong) id<setGrainTypeDelegate> grainTypeDelegate;
@end
