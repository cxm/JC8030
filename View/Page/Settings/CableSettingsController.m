//
//  CableSettingsController.m
//  JC8030
//
//  Created by cxm on 16/6/22.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "CableSettingsController.h"
#import "CableCell.h"
#import "CableOperation.h"
#import "AlarmSettingsController.h"

@interface CableSettingsController ()

@end

@implementation CableSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Cable Settings";
    [self readCables];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.tableFooterView=[[UIView alloc]init];
    
    if([self.flag isEqualToString:@"new"])
        next.hidden=NO;
    else
        next.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [textCableRadius resignFirstResponder];
    [textCableNumber resignFirstResponder];
    [textTSensors resignFirstResponder];
    [textMSensors resignFirstResponder];
    [textRotation resignFirstResponder];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%d",settingsItems.count);
    return cableArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"CableCell";
    CableCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"CableCell" owner:self options:nil]lastObject];
    }
    [cell setCable:cableArray[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.cable=cableArray[indexPath.row];
    textCableRadius.text=[NSString stringWithFormat:@"%d",self.cable.radius.intValue];
    textCableNumber.text=self.cable.cableNumber.description;
    textTSensors.text=self.cable.sensorCounts.description;
    textMSensors.text=self.cable.mCounts.description;
    textRotation.text=self.cable.rotation.description;
}

-(void)readCables{
    cableArray=[[CableOperation sharedCableOperation]getCablesByBinID:self.binID];
    NSLog(@"%lu",(unsigned long)cableArray.count);
    myTableView.rowHeight=113;
}
-(IBAction)gotoNext:(id)sender{
    AlarmSettingsController *page=[[AlarmSettingsController alloc]init];
    page.binID=self.binID;
    [self.navigationController pushViewController:page animated:YES];
}

-(IBAction)editCable:(id)sender{
    int flag=0;
    if(textCableRadius.text.length==0||textCableNumber.text.length==0||textTSensors.text.length==0||textMSensors.text==0||textRotation.text.length==0){
        return;
    }
    NSNumber *cableNO=(NSNumber *)textCableNumber.text;
    for(Cable *cable in cableArray){
        if(cable.cableNumber.intValue==cableNO.intValue){
            flag=1;
            break;
        }
    }
    
    NSNumber *cableRadius=(NSNumber *)textCableRadius.text;
    NSNumber *cableNumber=(NSNumber *)textCableNumber.text;
    NSNumber *tSensors=(NSNumber *)textTSensors.text;
    NSNumber *mSensors=(NSNumber *)textMSensors.text;
    NSNumber *rotation=(NSNumber *)textRotation.text;
    NSString *cableType;
    if(mSensors.intValue==0)
        cableType=@"T";
    else
        cableType=@"M";
    NSString *curDate=[CXMGlobal getCurrentDateTime];
    
    if(flag==0){
        Cable *cable=[Cable cableWithID:@(0) binID:self.binID cableNumber:cableNumber cableType:cableType createdAt:curDate sensorCounts:tSensors mCounts:mSensors radius:cableRadius rotation:rotation removed:@(0) sensorSpacing:@(5) updatedAt:curDate];
        [[CableOperation sharedCableOperation]addCable:cable];
        [self initEdit];
    }
    if(flag==1){
        if(self.cable==NULL)
            return;
        self.cable.radius=cableRadius;
        self.cable.cableNumber=cableNumber;
        self.cable.cableType=cableType;
        self.cable.sensorCounts=tSensors;
        self.cable.mCounts=mSensors;
        self.cable.rotation=rotation;
        self.cable.updatedAt=curDate;
        [[CableOperation sharedCableOperation]modifyCable:self.cable];
        [self initEdit];
    }
    
    [self readCables];
    [myTableView reloadData];
}

-(void)initEdit{
    textCableRadius.text=@"";
    textCableNumber.text=@"";
    textTSensors.text=@"";
    textMSensors.text=@"";
    textRotation.text=@"";
    self.cable=NULL;
}
-(IBAction)deleteCable:(id)sender{
    if(self.cable==NULL)
        return;
    [[CableOperation sharedCableOperation]removeCable:self.cable.ID];
    [self readCables];
    [myTableView reloadData];
    [self initEdit];
}







@end
