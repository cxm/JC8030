//
//  MainSettingsController.h
//  JC8030
//
//  Created by cxm on 16/6/17.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"

@interface MainSettingsController : BaseConroller<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *tableView;
    NSArray *settingsItems;
}

@end
