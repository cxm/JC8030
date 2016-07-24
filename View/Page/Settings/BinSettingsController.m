//
//  BinSettingsController.m
//  JC8030
//
//  Created by cxm on 16/6/22.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BinSettingsController.h"
#import "AddNewBinController.h"

@interface BinSettingsController ()

@end

@implementation BinSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)addNewBin:(id)sender{
    AddNewBinController *addNewPage=[[AddNewBinController alloc]init];
    
    [self.navigationController pushViewController:addNewPage animated:YES];
}
@end
