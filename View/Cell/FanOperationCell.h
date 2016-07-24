//
//  FanOperationCell.h
//  JC8030
//
//  Created by cxm on 16/7/18.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fans.h"

@interface FanOperationCell : UITableViewCell{
    IBOutlet UILabel *labelFanOp;
    IBOutlet UILabel *labelFanName;
    IBOutlet UIButton *start;
    IBOutlet UIButton *stop;
    Fans *fan;
}
-(void)setFan:(Fans *)fan;
@property int index;
@end
