//
//  GeneralSettingsControllerViewController.h
//  JC8030
//
//  Created by cxm on 16/6/22.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"
#import "Unit Table.h"


@interface GeneralSettingsController : BaseConroller{
    IBOutlet UITextField *phoneNumber;
    IBOutlet UITableView *temperatureUnitTableView;
    IBOutlet UITableView *weightUnitTableView;
    Unit_Table *tempTable;
    Unit_Table *weightTable;
    
}
@end
