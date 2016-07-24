//
//  GeneralSettingsControllerViewController.m
//  JC8030
//
//  Created by cxm on 16/6/22.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "GeneralSettingsController.h"


@interface GeneralSettingsController ()

@end

@implementation GeneralSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    //phoneNumber.keyboardType=UIKeyboardTypePhonePad;
    self.title=@"System Settings";
    [self readSettings];
    [self setNavigationRight:@"" title:@"Done" tab:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)readSettings{
    //phoneNumber
    NSString *phone=[CXMGlobal getStationPhoneNumber];
    phoneNumber.text=phone;
    //温度单位设置项
    tempTable=[Unit_Table initWithUnits:@"Temperature Units"];
    [tempTable readSettings];
    temperatureUnitTableView.dataSource=tempTable;
    temperatureUnitTableView.delegate=tempTable;
    temperatureUnitTableView.tableFooterView=[[UIView alloc]init];//去除多余分割线
    //重量单位设置项
    weightTable=[Unit_Table initWithUnits:@"Weight Units"];
    [weightTable readSettings];
    weightUnitTableView.dataSource=weightTable;
    weightUnitTableView.delegate=weightTable;
    weightUnitTableView.tableFooterView=[[UIView alloc]init];//去除多余分割线
}

- (IBAction)doRight:(id)sender
{
    [CXMGlobal setStationPhoneNumber:phoneNumber.text];
    [tempTable saveSettings];
    [weightTable saveSettings];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
