//
//  GrainTypecontrollerViewController.m
//  JC8030
//
//  Created by cxm on 16/7/2.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "GrainTypeController.h"


@implementation GrainTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Select Grain Type";
    _grainTable=[GrainType_Table init];
    tableView.dataSource=_grainTable;
    tableView.delegate=_grainTable;
    tableView.tableFooterView=[[UIView alloc]init];//去除多余分割线
    [self setNavigationRight:@"" title:@"Done" tab:@"nav"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doRight:(id)sender{
    if(self.grainTypeDelegate&&[self.grainTypeDelegate respondsToSelector:@selector(setGrainType:)]){
        [self.grainTypeDelegate setGrainType:self.grainTable.selectedGrainType];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
