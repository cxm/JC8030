//
//  AmibentCell.m
//  JC8030
//
//  Created by cxm on 16/7/17.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "AmibentCell.h"

@implementation AmibentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setAmbient:(NSString *)ambient{
    ambientLabel.text=ambient;
}
@end
