//
//  MoreSensorDataController.m
//  JC8030
//
//  Created by cxm on 16/7/18.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "MoreSensorDataController.h"
#import "BinSumOperation.h"
#import "MoreDataCell.h"

@interface MoreSensorDataController (){
    NSArray *binSums;
}

@end

@implementation MoreSensorDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    textStart.delegate=self;
    textEnd.delegate=self;
    [self readData];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    myTableView.rowHeight=60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)readData{
    binSums=[[NSArray alloc]init];
    //if(textStart.text.length!=0&&textEnd.text.length!=0){
        NSString *start=textStart.text;
        NSString *end=textEnd.text;
        binSums=[[BinSumOperation sharedBinSumOperation]getAllSumByBinID:self.binID layer:@(0) startDate:start endDate:end];
        //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
//        NSDate *dateA = [dateFormatter dateFromString:start];
//        NSDate *dateB = [dateFormatter dateFromString:end];
//        NSComparisonResult result = [dateA compare:dateB];
//        if(result==NSOrderedDescending||NSOrderedSame){
//            binSums=[[BinSumOperation sharedBinSumOperation]getAllSumByBinID:self.binID layer:@(0) startDate:start endDate:end];
//            
//        }else{
        
            
//        }
    //}
}
-(IBAction)queryData:(id)sender{
    [self readData];
    [myTableView reloadData];
}
-(IBAction)allData:(id)sender{
    textStart.text=@"";
    textEnd.text=@"";
    [self readData];
    [myTableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%d",settingsItems.count);
    return binSums.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"MoreDataCell";
    MoreDataCell  *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"MoreDataCell" owner:tableView options:nil]lastObject];
    }
    [cell setSum:(BinSum *)binSums[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.updataDelegate&&[self.updataDelegate respondsToSelector:@selector(updataWithTime:binSum:)]){
        [self.updataDelegate updataWithTime:[NSString stringWithFormat:@"Gather Time:%@",((BinSum *)binSums[indexPath.row]).gatherTime] binSum:(BinSum *)binSums[indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField.tag==123){
        [self selectData:textField];
        return NO;
    }else{
        return YES;
    }
}
-(void)selectData:(UITextField *)textField{
    if (IOS8) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert.view addSubview:datePicker];
        //解释2: handler是一个block,当点击ok这个按钮的时候,就会调用handler里面的代码.
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Select" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            
            //实例化一个NSDateFormatter对象
            [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
            
            NSString *dateString = [dateFormat stringFromDate:datePicker.date];
            textField.text=dateString;
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        
        [alert addAction:ok];//添加按钮
        
        [alert addAction:cancel];//添加按钮
        //以modal的形式
        [self presentViewController:alert animated:YES completion:^{ }];
    }
   }
@end
