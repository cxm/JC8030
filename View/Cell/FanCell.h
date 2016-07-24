//
//  FanCell.h
//  JC8030
//
//  Created by cxm on 16/7/7.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fans.h"

@interface FanCell : UITableViewCell{
    
}
@property int index;
@property IBOutlet UILabel *labelFanNo;
@property IBOutlet UITextField *textFanName;
@property IBOutlet UISwitch *switchFanState;
-(void)setFan:(Fans *)fan;
@end
