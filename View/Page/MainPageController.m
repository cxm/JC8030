//
//  MainPageController.m
//  JC8030
//
//  Created by cxm on 16/6/17.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "MainPageController.h"
#import "GeneralSettingsController.h"
#import "AddNewBinController.h"
#import "BinOperation.h"
#import "BinSumOperation.h"
#import "BinSummary.h"
#import "BinSummaryCell.h"
#import "DetailPageController.h"
#import "MainSettingsController.h"
#import "OtherSensorPageController.h"
#import "FansPageController.h"
#import "TempPageController.h"
#import "cxmController.h"

@interface MainPageController ()

@end

@implementation MainPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"Bin Summary";
    [self setNavigationRight:@"settings.png" title:@"" tab:@"nav"];
    [self setNavigationLeftOnlyBack:@""];
    [self readBinSummarys];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    
    myTableView.tableFooterView=[[UIView alloc]init];//去除多余分割线
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)doRight:(id)sender
{
    GeneralSettingsController *page=[[GeneralSettingsController alloc]init];
    [self.navigationController pushViewController:page animated:YES];
    //cxmController *page=[[cxmController alloc]init];
    //[self.navigationController pushViewController:page animated:YES];
}

-(IBAction)addNew:(id)sender{
    AddNewBinController *page=[[AddNewBinController alloc]init];
    page.flag=@"new";
    [self.navigationController pushViewController:page animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%d",settingsItems.count);
    return binSummarys.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"BinSummaryCell";
    BinSummaryCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"BinSummaryCell" owner:tableView options:nil]lastObject];
    }
    [cell setSummary:binSummarys[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailPageController *tabPage=[[DetailPageController alloc]init];
    TempPageController *tempPage=[[TempPageController alloc]init];
    OtherSensorPageController *otherPage=[[OtherSensorPageController alloc]init];
    FansPageController *fansPage=[[FansPageController alloc]init];
    MainSettingsController *setPage=[[MainSettingsController alloc]init];
    tabPage.viewControllers=@[tempPage,otherPage,fansPage,setPage];
    for(UIViewController *controller in tabPage.viewControllers){
        ((BaseConroller *)controller).binSummary=binSummarys[indexPath.row];
        [controller viewDidLoad];
    }
    //tabPage.navigationItem.title=((BinSummary *)binSummarys[indexPath.row]).binName;
    [self.navigationController pushViewController:tabPage animated:YES];
}


-(void)readBinSummarys{
    NSArray *allBins=[[BinOperation sharedBinOperation]getAllBin];
    binSummarys=[[NSMutableArray alloc]init];
    for(Bin *bin in allBins){
        
        BinSum *binSum=[[BinSumOperation sharedBinSumOperation]getLastSumByBinID:bin.ID layer:@(0)];
        BinSummary *binSummary=[BinSummary binSummaryWithBinID:bin.ID binType:bin.binType binName:bin.binName grainType:bin.grainType level:bin.level bushels:bin.bushels binImage:bin.binImage layer:binSum.layer gatherTime:binSum.gatherTime  avgT:binSum.avgT avgM:binSum.avgM];
        [binSummarys addObject:binSummary];
    }
    //NSLog(@"image:%@",((BinSummary *)binSummarys[0]).binImage);
    
    //UIImage *img=[UIImage imageWithData:((BinSummary *)binSummarys[0]).binImage];
    myTableView.rowHeight=95;
}










@end
