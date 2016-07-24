//
//  MoreDataCell.m
//  JC8030
//
//  Created by cxm on 16/7/18.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "MoreDataCell.h"

@implementation MoreDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSum:(BinSum *)binSum{
    labelGatherTime.text=binSum.gatherTime;
    labelMax.text=[CXMGlobal getStringTemp:binSum.maxT.description isUnit:1];
    labelAvg.text=[CXMGlobal getStringTemp:binSum.avgT.description isUnit:1];
    labelMin.text=[CXMGlobal getStringTemp:binSum.minT.description isUnit:1];
}
@end
