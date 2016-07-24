//
//  CableCell.h
//  JC8030
//
//  Created by cxm on 16/7/5.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cable.h"
@interface CableCell : UITableViewCell{
    IBOutlet UILabel *labelRadius;
    IBOutlet UILabel *labelNumber;
    IBOutlet UILabel *labelTSensors;
    IBOutlet UILabel *labelMSensors;
    IBOutlet UILabel *labelRotation;
}
-(void)setCable:(Cable *)cable;
@end
