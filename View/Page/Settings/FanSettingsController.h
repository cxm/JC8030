//
//  FanSettingsController.h
//  JC8030
//
//  Created by cxm on 16/6/22.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"


@interface FanSettingsController : BaseConroller<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *myTableview;
    NSArray *fansArray;
}
@property(nonatomic,copy)NSString *flag;
@end
