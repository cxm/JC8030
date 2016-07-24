//
//  CableSettingsController.h
//  JC8030
//
//  Created by cxm on 16/6/22.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"
#import "Cable.h"
#import "CableOperation.h"
@interface CableSettingsController : BaseConroller<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITextField *textCableRadius;
    IBOutlet UITextField *textCableNumber;
    IBOutlet UITextField *textTSensors;
    IBOutlet UITextField *textMSensors;
    IBOutlet UITextField *textRotation;
    IBOutlet UITableView *myTableView;
    IBOutlet UIButton *updateButton;
    IBOutlet UIButton *deleteButton;
    IBOutlet UIButton *next;
    NSMutableArray *cableArray;
}
@property(nonatomic,strong)Cable *cable;
@property(nonatomic,copy)NSString *flag;
@end
