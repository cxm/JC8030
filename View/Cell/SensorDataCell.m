//
//  SensorDataCell.m
//  JC8030
//
//  Created by cxm on 16/7/10.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "SensorDataCell.h"
#import "SensorData.h"
#import "Cable.h"

@implementation SensorDataCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setSensorData:(int)layer sensorDatas:(NSArray *)sensorDatas cables:(NSArray *)cables dataType:(NSString *)dataType{
    //删除原来内容
    for(int i=0;i<self.contentView.subviews.count;i++){
        [[self.contentView.subviews objectAtIndex:i]removeFromSuperview];
    }
    CGFloat x=8,y=8;
    UILabel *tempLabel;
    //表头
    if(layer==0){
        UILabel *firstLab=[[UILabel alloc]init];
        CGRect firstRect=CGRectMake(x, y, 40, 40);
        firstLab.frame=firstRect;
        [self.contentView addSubview:firstLab];
        tempLabel=firstLab;
        for(Cable *cable in cables){
            if([dataType isEqualToString:@"T"]||[dataType isEqualToString:@"L"]){
                UILabel *label=[[UILabel alloc]init];
                x=CGRectGetMaxX(tempLabel.frame);
                label.frame=CGRectMake(x, y, 40, 40);
                label.text=[cable.cableType stringByAppendingString:cable.cableNumber.description];
                [self.contentView addSubview:label];
                tempLabel=label;
            }else{
                if([cable.cableType isEqualToString:@"T"])
                    continue;
                UILabel *label=[[UILabel alloc]init];
                x=CGRectGetMaxX(tempLabel.frame);
                label.frame=CGRectMake(x, y, 40, 40);
                label.text=[cable.cableType stringByAppendingString:cable.cableNumber.description];
                [self.contentView addSubview:label];
                tempLabel=label;
            }
        }
    }else{
    //表内容
        
    }
}








@end
