//
//  AlarmSettingsController.h
//  JC8030
//
//  Created by cxm on 16/6/22.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"

@interface AlarmSettingsController : BaseConroller{
    IBOutlet UITextField *textHigh;
    IBOutlet UITextField *textRate;
    IBOutlet UIButton *buttonDay;
    IBOutlet UIButton *buttonWeek;
    IBOutlet UIButton *btnSave;
    NSString *changeType;
    NSArray *alarmRules;
}
@property(nonatomic,copy)NSString *flag;
@end
