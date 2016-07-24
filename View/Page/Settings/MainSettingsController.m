//
//  MainSettingsController.m
//  JC8030
//
//  Created by cxm on 16/6/17.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "MainSettingsController.h"
#import "PageInfo.h"

@interface MainSettingsController ()

@end

@implementation MainSettingsController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title=[self.binSummary.binName stringByAppendingString:@" SETTINGS"];
    [self setNavigationRight:@"" title:@"" tab:@"tab"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSettingsItem];
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.tableFooterView=[[UIView alloc]init];
    self.tabBarItem.image=[UIImage imageNamed:@"set.png"];
    self.tabBarItem.selectedImage=[UIImage imageNamed:@"set_selected.png"];
    self.tabBarItem.title=@"Settings";
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.tabBarController.navigationItem.backBarButtonItem=item;
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%d",settingsItems.count);
    return settingsItems.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    UIViewController *view=settingsItems[indexPath.row];
    cell.textLabel.text=view.title;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *view=settingsItems[indexPath.row];
    ((BaseConroller *)view).binID=self.binSummary.binID;
    
    [self.navigationController pushViewController:view animated:YES];
}
#pragma  mark 加载设置项
-(void) initSettingsItem{
    settingsItems=[PageInfo pageControllers:@"SettingsItem List"];
}
@end
