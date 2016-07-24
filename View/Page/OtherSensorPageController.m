//
//  OtherSensorPageController.m
//  JC8030
//
//  Created by cxm on 16/7/7.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "OtherSensorPageController.h"
#import "SensorDataOperation.h"
@interface OtherSensorPageController ()

@end

@implementation OtherSensorPageController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title=[self.binSummary.binName stringByAppendingString:@" OTHERS"];
    [self setNavigationRight:@"" title:@"" tab:@"tab"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarItem.image=[UIImage imageNamed:@"other.png"];
    self.tabBarItem.selectedImage=[UIImage imageNamed:@"other_selected.png"];
    self.tabBarItem.title=@"Others";
    self.binID=self.binSummary.binID;
    self.gatherTime=self.binSummary.gatherTime;
    if(_gatherTime==nil)
        _gatherTime=@"";
    lasUpdate.text=[@"Last Update:" stringByAppendingString:_gatherTime];
    [self readData];
    myTableView.dataSource=self;
    myTableView.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)readData{
    SensorData *sensorData=[[SensorDataOperation sharedSensorDataOperation]getlastAmbient:self.binID cableType:@"O" gatherTime:self.gatherTime];
    NSArray *temps;
    NSArray *hums;
    NSString *str;
    if(sensorData.temp==nil||sensorData.hum==nil){
        temps=@[@"--",@"--",@"--"];
        hums=@[@"--",@"--",@"--"];
    }else{
        temps=[sensorData.temp componentsSeparatedByString:@","];
        hums=[sensorData.hum componentsSeparatedByString:@","];
    }
    ambientArray=[[NSMutableArray alloc]init];
    for(int i=0;i<3;i++){
        str=@"Temp  ";
        str=[str stringByAppendingString:[CXMGlobal getStringTemp:temps[i] isUnit:1]];
        str=[str stringByAppendingString:@"       RH  "];
        str=[str stringByAppendingString:[hums[i] stringByAppendingString:@"%"]];
        [ambientArray addObject:str];
        NSLog(@"%@",str);
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%d",settingsItems.count);
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    
    AmibentCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"AmbientCell" owner:tableView options:nil]lastObject];;
    }
    [cell setAmbient:ambientArray[indexPath.section]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title;
    if(section==0)
        title=@"Ambient";
    if(section==1)
        title=@"HeadSpace";
    if(section==2)
        title=@"Plenum";
    return title;
}

@end
