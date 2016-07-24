//
//  DataTable.m
//  JC8030
//
//  Created by cxm on 16/7/9.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "DataTable.h"
#import "CableOperation.h"
#import "Cable.h"
#import "SensorDataOperation.h"
#import "SensorData.h"
#import "XCMultiSortTableView.h"
#import "MoreSensorDataController.h"
#import "TempPageController.h"
#import "AlarmOperation.h"

@interface DataTable ()<XCMultiTableViewDataSource, XCMultiTableViewDelegate>{
    XCMultiTableView *tableView;
    NSString *highAlarm;
}

@end

@implementation DataTable{
    NSMutableArray *headData;
    NSMutableArray *leftTableData;
    NSMutableArray *rightTableData;
}

-(void)viewWillAppear:(BOOL)animated{
    [self readCables];
    [self getMaxLayers];
    [self updateData];
    tableView.datasource = self;
    tableView.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    tableView = [[XCMultiTableView alloc] initWithFrame:CGRectInset(self.view.bounds, 5.0f, 35.0f)];
    tableView.leftHeaderEnable = YES;
    [self.view addSubview:tableView];
    UIButton *btnMore=[[UIButton alloc]init];
    btnMore.titleLabel.text=@"More";
    btnMore.frame=CGRectMake(0, tableView.frame.size.height, tableView.frame.size.width, 40);
    //NSLog(@"table:%f",tableView.frame.size.height);
    [self.view addSubview:btnMore];
    
    //alrm
    NSArray *alarmArry=[[AlarmOperation sharedAlarmOperation]getAlarmRulesBybinID:self.binID];
    if(alarmArry.count!=0){
        for(AlarmRules *alarm in alarmArry){
            if([alarm.ruleType isEqualToString:@"high"]){
                highAlarm=alarm.value.description;
            }
        }
    }else{
        highAlarm=@"";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)updateData{
    [self readDatas];
    [self setData];
    [tableView reloadData];
}
-(IBAction)MoreData:(id)sender{
    MoreSensorDataController *moreData=[[MoreSensorDataController alloc]initWithNibName:@"MoreSensorData" bundle:nil];
    moreData.updataDelegate=self;
    moreData.binID=self.binID;
    [self.navigationController pushViewController:moreData animated:YES];
}
-(void)getMaxLayers{
    if(cableList.count==0)
        maxLayers=0;
    for(Cable *cable in cableList){
        if([self.dataType isEqualToString:@"T"]||[self.dataType isEqualToString:@"L"]){
            if(cable.sensorCounts.intValue>maxLayers)
                maxLayers=cable.sensorCounts.intValue;
        }
        if([self.dataType isEqualToString:@"M"]){
            if([cable.cableType isEqualToString:@"T"])
                continue;
            if(cable.mCounts.intValue>maxLayers)
                maxLayers=cable.mCounts.intValue;

        }
    }
}

//更多数据代理
-(void)updataWithTime:(NSString *)gatherTime binSum:(BinSum *)binSum{
    ((TempPageController *)self.parentViewController).labelGatherTime=gatherTime;
    ((TempPageController *)self.parentViewController).binSum=binSum;
    ((TempPageController *)self.parentViewController).flag=@"update";
    [((TempPageController *)self.parentViewController) setData];
}
-(void)setData{
    headData=[[NSMutableArray alloc]init];
    leftTableData=[[NSMutableArray alloc]init];
    rightTableData=[[NSMutableArray alloc]init];
    
    if(cableList==nil||cableList.count==0)
        return;
    for(Cable * cable in cableList){
        if([self.dataType isEqualToString:@"T"]||[self.dataType isEqualToString:@"L"])
            [headData addObject:[cable.cableType stringByAppendingString:cable.cableNumber.description]];
        else{
            if([cable.cableType isEqualToString:@"T"])
                continue;
            [headData addObject:[cable.cableType stringByAppendingString:cable.cableNumber.description]];
        }
    }
    
   
    for(int i=maxLayers;i>=1;i--){
        [leftTableData addObject:[NSString stringWithFormat:@"S%i",i]];
    }
    if(sensorDatas==nil||sensorDatas.count==0)
        return;
    
    for(int i=maxLayers;i>=1;i--){
        NSMutableArray *row=[[NSMutableArray alloc]init];
        for(NSArray *sensorData in sensorDatas){
            if(sensorData.count>=i){
                [row addObject:sensorData[i-1]];
            }else{
                [row addObject:@""];
            }
        }
        [rightTableData addObject:row];
    }
    [tableView reloadData];
}

-(void)readDatas{
    sensorDatas=NULL;
    sensorDatas=[[NSMutableArray alloc]init];
    if(self.gatherTime==nil)
        return;
    NSArray *datas=[[SensorDataOperation sharedSensorDataOperation]getLastRecordByBinID:self.binID gatherTime:self.gatherTime];
    if(datas.count==0)return;
    for(SensorData *sensorData in datas){
        NSString *strData;
        if([self.dataType isEqualToString:@"T"])
            strData=sensorData.temp;
        else if([self.dataType isEqualToString:@"M"]){
            if([sensorData.cableType isEqualToString:@"M"])
                strData=sensorData.hum;
            else
                continue;
        }
        else{
            strData=sensorData.temp;
        }
        [sensorDatas addObject:[strData componentsSeparatedByString:@","]];
    }
}

-(void)readCables{
    cableList=[[CableOperation sharedCableOperation]getCablesByBinID:self.binID];
}

#pragma mark - XCMultiTableViewDataSource


- (NSArray *)arrayDataForTopHeaderInTableView:(XCMultiTableView *)tableView {
    return [headData copy];
}
- (NSArray *)arrayDataForLeftHeaderInTableView:(XCMultiTableView *)tableView InSection:(NSUInteger)section {
    return leftTableData;
}

- (NSArray *)arrayDataForContentInTableView:(XCMultiTableView *)tableView InSection:(NSUInteger)section {
    return rightTableData;
}


- (NSUInteger)numberOfSectionsInTableView:(XCMultiTableView *)tableView {
    return 1;
}

- (AlignHorizontalPosition)tableView:(XCMultiTableView *)tableView inColumn:(NSInteger)column {
//    if (column == 0) {
//        return AlignHorizontalPositionCenter;
//    }else if (column == 1) {
//        return AlignHorizontalPositionRight;
//    }
    return AlignHorizontalPositionCenter;
}

//单元格宽度
- (CGFloat)tableView:(XCMultiTableView *)tableView contentTableCellWidth:(NSUInteger)column {
    if (column == 0) {
        return 35.0f;
    }
    return 35.0f;
}

//单元格高度
- (CGFloat)tableView:(XCMultiTableView *)tableView cellHeightInRow:(NSUInteger)row InSection:(NSUInteger)section {
    if (section == 0) {
        return 35.0f;
    }else {
        return 35.0f;
    }
}

- (UIColor *)tableView:(XCMultiTableView *)tableView1 bgColorInSection:(NSUInteger)section InRow:(NSUInteger)row InColumn:(NSUInteger)column {
    UIColor *color=[UIColor clearColor];
    if(column!=-1)
    {
    color=[CXMGlobal getColorWithTemp:rightTableData[row][column] highAlarm:highAlarm];
    //NSLog(@"seciton:%d  row:%d  column:%d",section,row,column);
    }
    return color;
}

//- (UIColor *)tableView:(XCMultiTableView *)tableView headerBgColorInColumn:(NSUInteger)column {
//    if (column == -1) {
//        return [UIColor redColor];
//    }else if (column == 1) {
//        return [UIColor grayColor];
//    }
//    return [UIColor clearColor];
//}

- (NSString *)vertexName {
    return @"";
}

#pragma mark - XCMultiTableViewDelegate

- (void)tableViewWithType:(MultiTableViewType)tableViewType didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tableViewType:%@, selectedIndexPath: %@", @(tableViewType), indexPath);
}





@end
