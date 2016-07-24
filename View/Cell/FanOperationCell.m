//
//  FanOperationCell.m
//  JC8030
//
//  Created by cxm on 16/7/18.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "FanOperationCell.h"
#import "Frame.h"
#import "Client.h"
#import "BinOperation.h"

@implementation FanOperationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFan:(Fans *)fan1{
    fan=fan1;
    labelFanName.text=fan.fanName;
    labelFanOp.text=fan.status;
}

-(IBAction)startFan:(id)sender{
    NSMutableArray *dataArea=[[NSMutableArray alloc]init];
    Frame *frame=[[Frame alloc]init];
    [dataArea addObject:fan.fanNumber];
    [dataArea addObject:@(1)];
    [dataArea addObject:@(0)];
    [dataArea addObject:@(0)];
    Bin *bin=[[BinOperation sharedBinOperation]getBinByID:fan.binID];
    NSData *sendData=[frame getCommonFrame:(Byte)bin.stationID.intValue fromAddr:0xFE cmd:0x12 dataArea:dataArea];
    [[Client sharedClient]sendData:sendData];
    labelFanOp.text=@"Command Send";
}

-(IBAction)stopFan:(id)sender{
    NSMutableArray *dataArea=[[NSMutableArray alloc]init];
    Frame *frame=[[Frame alloc]init];
    [dataArea addObject:fan.fanNumber];
    [dataArea addObject:@(0)];
    [dataArea addObject:@(0)];
    [dataArea addObject:@(0)];
    Bin *bin=[[BinOperation sharedBinOperation]getBinByID:fan.binID];
    NSData *sendData=[frame getCommonFrame:(Byte)bin.stationID.intValue fromAddr:0xFE cmd:0x12 dataArea:dataArea];
    [[Client sharedClient]sendData:sendData];
    labelFanOp.text=@"Command Send";
}
@end
