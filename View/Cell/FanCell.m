//
//  FanCell.m
//  JC8030
//
//  Created by cxm on 16/7/7.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "FanCell.h"

@implementation FanCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFan:(Fans *)fan{
    self.labelFanNo.text=fan.fanNumber.description;
    self.textFanName.text=fan.fanName;
    
    if(fan.removed.integerValue==1)
       [self.switchFanState setOn:NO animated:YES];
    else
        [self.switchFanState setOn:YES animated:YES];
    
    //NSLog(@"%@",@(self.switchFanState.isOn));
}
@end
