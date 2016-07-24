//
//  FanSettingsController.m
//  JC8030
//
//  Created by cxm on 16/6/22.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "FanSettingsController.h"
#import "FanCell.h"
#import "FanOperation.h"

@interface FanSettingsController ()

@end

@implementation FanSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    myTableview.dataSource=self;
    myTableview.delegate=self;
    myTableview.tableFooterView=[[UIView alloc]init];
    if(![self.flag isEqualToString:@"new"]){
        [self readFans];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%d",settingsItems.count);
    return fansArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"FanCell";
    FanCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"FanCell" owner:self options:nil]lastObject];
    }
    [cell setFan:fansArray[indexPath.row]];
    cell.index=(int)indexPath.row;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)readFans{
    fansArray=[[FanOperation sharedFanOperation]getFansByBinID:self.binID];
    if(fansArray==NULL||fansArray.count==0){
        [[FanOperation sharedFanOperation]initFansByBinID:self.binID];
    }
    fansArray=[[FanOperation sharedFanOperation]getFansByBinID:self.binID];
    if(fansArray.count!=0){
        NSLayoutConstraint *layout=[NSLayoutConstraint constraintWithItem:myTableview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:44.0f*fansArray.count+8.f];
        layout.active = YES;
    }
}

-(IBAction)saveSettings:(id)sender{
    for(FanCell *cell in myTableview.visibleCells){
        Fans *fan=(Fans *)fansArray[cell.index];
        fan.fanName=cell.textFanName.text;
        if(cell.switchFanState.isOn)
            fan.removed=@(0);
        else
            fan.removed=@(1);
        [[FanOperation sharedFanOperation]modifyFan:fan];
    }
}










@end
