//
//  AlarmSettingsController.m
//  JC8030
//
//  Created by cxm on 16/6/22.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "AlarmSettingsController.h"
#import "AlarmOperation.h"
#import "AlarmRules.h"
#import "FanSettingsController.h"

@interface AlarmSettingsController ()

@end

@implementation AlarmSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([self.flag isEqual:@"new"]){
        [btnSave setTitle:@"Next" forState:UIControlStateNormal];
    }
    else{
        [btnSave setTitle:@"Save" forState:UIControlStateNormal];
        [self readSettings];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)selectDay:(id)sender{
    changeType=@"day";
    [self setSelectedButton:buttonDay];
}

-(IBAction)selectWeek:(id)sender{
    changeType=@"week";
    [self setSelectedButton:buttonWeek];
}

-(IBAction)saveSettigs:(id)sender{
    [[AlarmOperation sharedAlarmOperation]removeAlarmByBinID:self.binID ruleType:@"high"];
    if(textHigh.text!=NULL && ![textHigh.text isEqualToString:@""]){
        [[AlarmOperation sharedAlarmOperation]addAlarmRule:[AlarmRules AlarmRulesWithID:@(0) binID:self.binID ruleType:@"high" value:(NSNumber *)textHigh.text]];
    }
    [[AlarmOperation sharedAlarmOperation]removeAlarmByBinID:self.binID ruleType:@"day"];
    [[AlarmOperation sharedAlarmOperation]removeAlarmByBinID:self.binID ruleType:@"week"];
    if(textRate.text!=NULL && ![textRate.text isEqualToString:@""]){
        [[AlarmOperation sharedAlarmOperation]addAlarmRule:[AlarmRules AlarmRulesWithID:@(0) binID:self.binID ruleType:changeType value:(NSNumber *)textRate.text]];
    }
    //跳转
    if([self.flag isEqual:@"new"]){
        FanSettingsController *page=[[FanSettingsController alloc]init];
        page.binID=self.binID;
        [self.navigationController pushViewController:page animated:YES];
    }
}

-(void)readSettings{
    alarmRules=[[AlarmOperation sharedAlarmOperation]getAlarmRulesBybinID:self.binID];
    for(AlarmRules *alarm in alarmRules){
        if([alarm.ruleType isEqualToString:@"high"])
            textHigh.text=alarm.value.description;
        if([alarm.ruleType isEqualToString:@"day"]){
            textRate.text=alarm.value.description;
            [self setSelectedButton:buttonDay];
        }
        if([alarm.ruleType isEqualToString:@"week"]){
            textRate.text=alarm.value.description;
            [self setSelectedButton:buttonWeek];
        }
    }
}

-(void)setSelectedButton:(UIButton *)button{
    [buttonDay setImage:[UIImage imageNamed:@"radio0.png"] forState:UIControlStateNormal];
    [buttonWeek setImage:[UIImage imageNamed:@"radio0.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"radio1.png"] forState:UIControlStateNormal];
}
@end
