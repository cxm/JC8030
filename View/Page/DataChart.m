//
//  DataChart.m
//  JC8030
//
//  Created by cxm on 16/7/9.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "DataChart.h"
#import "JC8030-Charts-Header.h"
#import <Charts/Charts.h>
#import "BinSumOperation.h"
#import "CableOperation.h"
#import "SensorDataOperation.h"
@interface DataChart () <ChartViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    IBOutlet UILabel *labelCable;
    IBOutlet UITextField *textStartDate;
    IBOutlet UITextField *textEndDate;
    IBOutlet UIButton *btnBin;
    IBOutlet UIButton *btnCable;
    NSMutableArray *dataSets;//所有line集合
    NSMutableArray *xValArray;
    UIPickerView *cablePicker;
    NSMutableArray *cableSensors;
    NSArray *cableList;
    Cable *cable;
    int selectCableNumber;
    int selectLayer;
}
@property (nonatomic, strong) IBOutlet LineChartView *chartView;

@end

@implementation DataChart
-(void)viewWillAppear:(BOOL)animated{
    [self setSummaryData];
    [self readCables];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setChart];
    
    textStartDate.delegate=self;
    textEndDate.delegate=self;
}

-(void)setChart{
    self.chartView.delegate=self;
    
    self.chartView.drawGridBackgroundEnabled=YES;
    self.chartView.gridBackgroundColor=[UIColor clearColor];
    self.chartView.descriptionText=@"";
    self.chartView.noDataTextDescription=@"No Data to Display";
    self.chartView.dragEnabled=YES;
    self.chartView.pinchZoomEnabled=YES;
    self.chartView.backgroundColor=[UIColor whiteColor];
    self.chartView.minOffset=30.0f;
    self.chartView.legend.position=ChartLegendPositionAboveChartRight;
    
    ChartXAxis *xAxis=self.chartView.xAxis;
    xAxis.labelPosition=XAxisLabelPositionBottom;
    
    ChartYAxis *leftAxis=self.chartView._leftAxis;
    [leftAxis setStartAtZeroEnabled:NO];
    [leftAxis setAxisMaxValue:[CXMGlobal getFloatTempNoUnit:60]];
    [leftAxis setAxisMaxValue:[CXMGlobal getFloatTempNoUnit:-30]];
    
    self.chartView._rightAxis.enabled=NO;
    
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
//    else{
//        //当在ios7上面运行的时候,
//        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
//        datePicker.datePickerMode = UIDatePickerModeDate;
//        //[datePicker addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];
//        
//        UIActionSheet* startsheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n"
//                                                                delegate:nil
//                                                       cancelButtonTitle:nil
//                                                  destructiveButtonTitle:nil
//                                                       otherButtonTitles:@"Select",
//                                     @"Cancel", nil];
//        startsheet.tag = 333;
//        //添加子控件的方式也是直接添加
//        [startsheet addSubview:datePicker];
//        [startsheet showInView:self.view];
//    }
}

-(void)readCables{
    cableList=[[CableOperation sharedCableOperation]getCablesByBinID:self.binID];
    [self getSensors:0];
}
-(void)getSensors:(int)index{
    cableSensors=[[NSMutableArray alloc]init];
    if(cableList.count>index){
        cable=cableList[index];
        int counts=cable.sensorCounts.intValue;
        if(counts==0)
            return;
        for(int i=1;i<=counts;i++){
            [cableSensors addObject:@(i)];
        }
    }
}
-(void)selectSensor{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    cablePicker=[[UIPickerView alloc]init];
    cablePicker.dataSource=self;
    cablePicker.delegate=self;
    [alert.view addSubview:cablePicker];
    //解释2: handler是一个block,当点击ok这个按钮的时候,就会调用handler里面的代码.
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Select" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        labelCable.text=[NSString stringWithFormat:@"Cable%d    S%d",selectCableNumber,selectLayer];
        [self setSensorDataWithCable:cable layer:selectLayer];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    [alert addAction:ok];//添加按钮
    
    [alert addAction:cancel];//添加按钮
    //以modal的形式
    [self presentViewController:alert animated:YES completion:^{ }];
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

#pragma mark UIPickerView dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
// UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return cableList.count;
    } else {
        return cableSensors.count;
    }
}
#pragma mark UIPickerView delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     NSString *str=@"☺︎";
    switch (component) {
        case 0:
            cable=(Cable *)cableList[row];
            str=[NSString stringWithFormat:@"%@%d",cable.cableType,cable.cableNumber.intValue];
            return str;
            break;
        case 1:
            return [NSString stringWithFormat:@"S%@",cableSensors[row]];
            break;
        default:
            return @"";
            break;
    }
}
// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            cable=(Cable *)cableList[row];
            selectCableNumber=cable.cableNumber.intValue;
            [self getSensors:(int)row];
            selectLayer=((NSNumber *)cableSensors[0]).intValue;
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            //NSLog(@"number:%d layer:%d",selectCableNumber,selectLayer);
            break;
        case 1:
            selectCableNumber=cable.cableNumber.intValue;
            selectLayer=((NSNumber *)cableSensors[row]).intValue;
            //NSLog(@"number:%d layer:%d",selectCableNumber,selectLayer);
            break;
    }
}

-(IBAction)binData:(id)sender{
    
    [self setSummaryData];
}

-(IBAction)sensorData:(id)sender{
    [self selectSensor];
}

-(IBAction)clearDateText:(id)sender{
    textStartDate.text=@"";
    textEndDate.text=@"";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setSummaryData{
    dataSets=[[NSMutableArray alloc]init];//所有line集合
    xValArray=[[NSMutableArray alloc]init];//x轴数据
    NSMutableArray *maxVals=[[NSMutableArray alloc]init];
    NSMutableArray *minVals=[[NSMutableArray alloc]init];
    NSMutableArray *avgVals=[[NSMutableArray alloc]init];
    NSArray *summarys=[[NSArray alloc]init];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDate *date;
    if(textStartDate.text.length!=0&&textEndDate.text.length!=0){
        NSString *start=textStartDate.text;
        NSString *end=textEndDate.text;
        if((NSDate *)start <=(NSDate *)end){
            summarys=[[BinSumOperation sharedBinSumOperation]getAllSumByBinID:self.binID layer:@(0) startDate:start endDate:end];
            if(summarys.count==0)
                return;
        }else{
            return;
        }
    }else
        summarys=[[BinSumOperation sharedBinSumOperation]getAllSumByBinID:self.binID layer:@(0) startDate:@"" endDate:@""];
    BinSum *binSum;
    for(int i=0;i<summarys.count;i++){
        binSum=(BinSum *)summarys[i];
        if([self.dataType isEqualToString:@"M"]){
            if(binSum.maxM.floatValue!=-100){
                [maxVals addObject:[[ChartDataEntry alloc]initWithValue:binSum.maxM.floatValue xIndex:i]];
            }
            if(binSum.minM.floatValue!=-100){
                [minVals addObject:[[ChartDataEntry alloc]initWithValue:binSum.minM.floatValue xIndex:i]];
            }
            if(binSum.avgM.floatValue!=-100){
                [avgVals addObject:[[ChartDataEntry alloc]initWithValue:binSum.avgM.floatValue xIndex:i]];
            }
        }else{
            if(binSum.maxT.floatValue!=-100){
                [maxVals addObject:[[ChartDataEntry alloc]initWithValue:binSum.maxT.floatValue xIndex:i]];
            }
            if(binSum.minT.floatValue!=-100){
                [minVals addObject:[[ChartDataEntry alloc]initWithValue:binSum.minT.floatValue xIndex:i]];
            }
            if(binSum.avgT.floatValue!=-100){
                [avgVals addObject:[[ChartDataEntry alloc]initWithValue:binSum.avgT.floatValue xIndex:i]];
            }
        }
        date=[dateFormatter dateFromString:binSum.gatherTime];
        [dateFormatter setDateFormat:@"YY/MM/dd HH:mm"];
        [xValArray addObject:[dateFormatter stringFromDate:date]];
        [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    }
    LineChartDataSet *lineDataSetMax=[[LineChartDataSet alloc]initWithYVals:maxVals label:@"Max"];
    lineDataSetMax.lineWidth=2;
    lineDataSetMax.drawCirclesEnabled=NO;
    lineDataSetMax.drawValuesEnabled=YES;
    [lineDataSetMax setColor:[UIColor colorWithRed:244/255.f green:96/255.f blue:84/255.f alpha:1]];
    [dataSets addObject:lineDataSetMax];
    
    LineChartDataSet *lineDataSetMin=[[LineChartDataSet alloc]initWithYVals:minVals label:@"Min"];
    lineDataSetMin.lineWidth=2;
    lineDataSetMin.drawCirclesEnabled=NO;
    lineDataSetMin.drawValuesEnabled=YES;
    [lineDataSetMin setColor:[UIColor colorWithRed:0/255.f green:128/255.f blue:64/255.f alpha:1]];
    [dataSets addObject:lineDataSetMin];
    
    LineChartDataSet *lineDataSetAvg=[[LineChartDataSet alloc]initWithYVals:avgVals label:@"Avg"];
    lineDataSetAvg.lineWidth=2;
    lineDataSetAvg.drawCirclesEnabled=NO;
    lineDataSetAvg.drawValuesEnabled=YES;
    [lineDataSetAvg setColor:[UIColor colorWithRed:0/255.f green:59/255.f blue:115/255.f alpha:1]];
    [dataSets addObject:lineDataSetAvg];
    
    LineChartData *lineData=[[LineChartData alloc]initWithXVals:xValArray dataSets:dataSets];
    [self.chartView setData:lineData];
    [self.chartView.data notifyDataChanged];
    [self.chartView notifyDataSetChanged];
}

-(void)setSensorDataWithCable:(Cable *)cable1 layer:(int)layer{
    if(layer==0)return;
    NSArray *sensorDatas=[[NSArray alloc]init];
    if(textStartDate.text.length!=0&&textEndDate.text.length!=0){
        NSString *start=textStartDate.text;
        NSString *end=textEndDate.text;
        if((NSDate *)start <=(NSDate *)end){
            sensorDatas=[[SensorDataOperation sharedSensorDataOperation]getRecords:self.binID cableType:cable.cableType cableNumber:cable1.cableNumber start:start end:end];
            if(sensorDatas.count==0)
                return;
        }else{
            return;
        }
    }else
        sensorDatas=[[SensorDataOperation sharedSensorDataOperation]getRecords:self.binID cableType:cable.cableType cableNumber:cable1.cableNumber start:@"" end:@""];
    if(self.chartView.lineData._dataSets.count>3)
        [self.chartView.lineData._dataSets delete:@(3)];
    NSMutableArray *vals=[[NSMutableArray alloc]init];
    SensorData *sensorData;
    for(int i=0;i<sensorDatas.count;i++){
        sensorData=(SensorData *)sensorDatas[i];
        NSArray *tempArray=[[NSArray alloc]init];
        if([self.dataType isEqualToString:@"M"]){
            tempArray=[(NSString *)sensorData.hum componentsSeparatedByString:@","];
            if(tempArray.count==0) continue;
            if([tempArray[layer-1] isEqualToString:@"--"]) continue;
            [vals addObject:[[ChartDataEntry alloc]initWithValue:((NSNumber *)tempArray[layer-1]).floatValue xIndex:i]];
        }else{
            tempArray=[(NSString *)sensorData.temp componentsSeparatedByString:@","];
            if(tempArray.count==0) continue;
            if([tempArray[layer-1] isEqualToString:@"--"]) continue;
            float tempValue=[CXMGlobal getFloatTempNoUnit:((NSNumber *)tempArray[layer-1]).floatValue];
            [vals addObject:[[ChartDataEntry alloc]initWithValue:tempValue xIndex:i]];
        }
    }
    
    LineChartDataSet *lineSetData=[[LineChartDataSet alloc]initWithYVals:vals label:@"Sensor"];
    lineSetData.lineWidth=3;
    lineSetData.drawCirclesEnabled=NO;
    lineSetData.drawValuesEnabled=YES;
    [lineSetData setColor:[UIColor colorWithRed:255 green:153 blue:18 alpha:1]];
    //dataSets=[[NSMutableArray alloc]init];
    [dataSets addObject:lineSetData];
    LineChartData *lineData=[[LineChartData alloc]initWithXVals:xValArray dataSets:dataSets];
    [self.chartView setData:lineData];
    [self.chartView notifyDataSetChanged];
}

-(void)updateData{
    
}







@end
