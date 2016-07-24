//
//  OtherSensorPageController.h
//  JC8030
//
//  Created by cxm on 16/7/7.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"
#import "AmibentCell.h"

@interface OtherSensorPageController : BaseConroller<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UILabel *lasUpdate;
    IBOutlet UITableView *myTableView;
    NSMutableArray *ambientArray;
}
@property(nonatomic,copy) NSString *gatherTime;
@end
