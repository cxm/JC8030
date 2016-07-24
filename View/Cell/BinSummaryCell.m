//
//  BinSummaryCell.m
//  JC8030
//
//  Created by cxm on 16/7/6.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BinSummaryCell.h"

@implementation BinSummaryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSummary:(BinSummary *)binSummary{
    labelBinName.text=binSummary.binName;
    labelGrainType.text=binSummary.grainType;
    NSString *avgTemp=[CXMGlobal getStringTemp:binSummary.avgT.description isUnit:1];
    NSString *strAvgM;
    if(binSummary.avgM.intValue==-100)
        strAvgM=@"--";
    else
        strAvgM=[NSString stringWithFormat:@"%d",binSummary.avgM.intValue];
    labelAvg.text=[NSString stringWithFormat:@"Temp(AVG)%@    RH %@%%",avgTemp,strAvgM];
    labelLevel.text=[NSString stringWithFormat:@"Level %@%%    Bushels %@",binSummary.level,binSummary.bushels];
    NSData *data=binSummary.binImage;
    UIImage *img=[UIImage imageWithData:data];
    imageViewBin.image=img;
}
@end
