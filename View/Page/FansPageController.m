//
//  FansPageController.m
//  JC8030
//
//  Created by cxm on 16/7/7.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "FansPageController.h"
#import "FanOperation.h"
#import "FanRecordOperation.h"
#import "FanOperationCell.h"

@interface FansPageController (){
    NSArray *fanList;
}

@end

@implementation FansPageController

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title=[self.binSummary.binName stringByAppendingString:@" FANS"];
    [self setNavigationRight:@"" title:@"" tab:@"tab"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.image=[UIImage imageNamed:@"fan.png"];
    self.tabBarItem.selectedImage=[UIImage imageNamed:@"fan_selected.png"];
    self.tabBarItem.title=@"Fans";
    self.binID=self.binSummary.binID;
    [self readFans];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.rowHeight=44;
    myTableView.tableFooterView=[[UIView alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNotify:) name:@"control" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNotify:) name:@"net" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)handleNotify:(NSNotification *)note{
    NSString *noteName=note.name;
    NSDictionary *dic=note.userInfo;
    if([noteName isEqualToString:@"control"]){
        NSNumber *binID=dic[@"binID"];
        NSNumber *fanNumber=dic[@"fanNumber"];
        NSString *fanState=dic[@"fanState"];
        if([fanState isEqualToString:@"1"])
            fanState=@"Open Successful";
        if([fanState isEqualToString:@"0"])
            fanState=@"Stop Successful";
        if(binID.intValue==self.binID.intValue){
            for(FanOperationCell *cell in myTableView.visibleCells){
                Fans *fan=(Fans *)fanList[cell.index];
                fan.status=fanState;
                if(fanNumber.intValue==fan.fanNumber.intValue){
                    [cell setFan:fan];
                    NSArray *array=@[cell];
                    [myTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationLeft];
                }
            }

        }
    }
    if([noteName isEqualToString:@"net"]){
        if([dic[@"connect"] isEqualToString:@"failed"]){
            for(FanOperationCell *cell in myTableView.visibleCells){
                ((Fans *)fanList[cell.index]).status=@"";
            }
            [myTableView reloadData];
            [CXMGlobal toastWithContent:@"connect failed!" time:1 controllerView:self.view];
        }
    }
}
-(void)readFans{
    fanList=[[FanOperation sharedFanOperation]getFansByBinID:self.binID];
}

#pragma mark tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%d",settingsItems.count);
    return fanList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"FanOperationCell";
    
    FanOperationCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"FanOperationCell" owner:tableView options:nil]lastObject];;
    }
    [cell setFan:fanList[indexPath.row]];
    cell.index=indexPath.row;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
