//
//  CableCell.m
//  JC8030
//
//  Created by cxm on 16/7/5.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "CableCell.h"

@implementation CableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCable:(Cable *)cable{
    [labelRadius setText:[NSString stringWithFormat:@"%d",cable.radius.intValue]];
    [labelNumber setText:cable.cableNumber.description];
    [labelTSensors setText:cable.sensorCounts.description];
    [labelMSensors setText:cable.mCounts.description];
    [labelRotation setText:cable.rotation.description];
}
@end
