//
//  TempPageController.m
//  JC8030
//
//  Created by cxm on 16/7/7.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "TempPageController.h"
#import "SensorDataOperation.h"
#import "BinSumOperation.h"
#import "CableOperation.h"
#import "Client.h"
#import "Frame.h"
#import "BinOperation.h"

@interface TempPageController (){
    NSString *dataType;
    NSTimer *timer;
}

@end

@implementation TempPageController

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title=[self.binSummary.binName stringByAppendingString:@" T&M"];
    [self setNavigationRight:@"update.png" title:@"" tab:@"tab"];
    
    self.binID=self.binSummary.binID;
    
    [self addSubControllers];
    [self setData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.image=[UIImage imageNamed:@"data.png"];
    self.tabBarItem.selectedImage=[UIImage imageNamed:@"data_selected.png"];
    self.tabBarItem.title=@"T&M";
    dataType=@"T";
    [self setTab];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNotify:) name:@"gather" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNotify:) name:@"net" object:nil];
}
//选项卡设置
-(void)setTab{
    NSArray *tabs=@[@"Table",@"Trend"];
    UIColor *normalColor=[UIColor darkGrayColor];
    UIColor *selectedColor=[UIColor colorWithRed:10/255.0 green:115/255.0 blue:255.0/255.0 alpha:1];
    UIColor *lineColor=[UIColor colorWithRed:10/255.0 green:115/255.0 blue:255.0/255.0 alpha:1];
    [tabView setUpStatusButtonWithTitlt:tabs NormalColor:normalColor SelectedColor:selectedColor LineColor:lineColor];
    tabView.delegate=self;
}
//选项卡delegate
- (void)statusViewSelectIndex:(NSInteger)index{
    if(index==0)
       [self addDataTable];
    else
        [self addDataChart];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//segment点击
-(IBAction)changeDataType:(UISegmentedControl *)sender{
    if(sender.selectedSegmentIndex==0){
        dataType=@"T";
    }else if(sender.selectedSegmentIndex==1){
        dataType=@"M";
        //[self stopUpdate];
    }
    else{
        dataType=@"L";
    }
    [self setData];
}
//通知事件
-(void)handleNotify:(NSNotification *)note{
    NSString *noteName=note.name;
    NSDictionary *dic=note.userInfo;
    if([noteName isEqualToString:@"gather"]){
        if([dic[@"gather"] isEqualToString:@"success"]){
            //更新数据
            [self setData];
        }else{
            [self stopUpdate];
        }
    }
    if([noteName isEqualToString:@"net"]){
        if([dic[@"connect"] isEqualToString:@"failed"]){
            [self stopUpdate];
            [CXMGlobal toastWithContent:@"connect failed!" time:1 controllerView:self.view];
        }
    }
}

//停止旋转
-(void)stopUpdate{
    UIView *update=self.tabBarController.navigationItem.rightBarButtonItem.customView;
    [update.layer removeAllAnimations];
    [self.tabBarController.navigationItem.rightBarButtonItem setEnabled:YES];
    if(timer!=nil)
        [timer invalidate];
}

//采集超时
-(void)gatherTimeOut{
    [CXMGlobal toastWithContent:@"connect failed!" time:1 controllerView:self.view];
    [self stopUpdate];
}
//采集数据
-(IBAction)doRight:(id)sender{
    NSArray *sensorCounts=[[CableOperation sharedCableOperation]getSensorCounts:self.binSummary.binID];
    short int tCounts=((NSNumber *)sensorCounts[0]).intValue;
    short int mCounts=((NSNumber *)sensorCounts[1]).intValue;
    if(tCounts==0&&mCounts==0)
        return;
    NSMutableArray *dataArea=[[NSMutableArray alloc]init];
    Frame *frame=[[Frame alloc]init];
    [dataArea addObject:@(tCounts&0xFF)];
    [dataArea addObject:@(tCounts>>8)];
    [dataArea addObject:@(mCounts)];
    Bin *bin=[[BinOperation sharedBinOperation]getBinByID:self.binSummary.binID];
    NSData *sendData=[frame getCommonFrame:(Byte)bin.stationID.intValue fromAddr:0xFE cmd:0x11 dataArea:dataArea];
    [[Client sharedClient]sendData:sendData];
    
    UIView *update=self.tabBarController.navigationItem.rightBarButtonItem.customView;
    [update.layer addAnimation:[self rotation:0.5 repeatCount:500] forKey:nil];
    [self.tabBarController.navigationItem.rightBarButtonItem setEnabled:NO];
    
    //定时器启动
    timer = [NSTimer timerWithTimeInterval:60 target:self selector:@selector(gatherTimeOut) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}


//旋转动画
-(CABasicAnimation *)rotation:(float)dur repeatCount:(int)repeatCount{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = dur;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeatCount;
    return rotationAnimation;
}


-(void)setData{
    if(![self.flag isEqualToString:@"update"]){
        self.binSum=[[BinSumOperation sharedBinSumOperation]getLastSumByBinID:self.binID layer:@(0)];
        gatherTime=self.binSum.gatherTime;
        self.labelGatherTime=[NSString stringWithFormat:@"Last Updae:%@",gatherTime];
    }else{
        gatherTime=self.binSum.gatherTime;
    }
    
    labelLastUpdate.text=self.labelGatherTime;
    if([dataType isEqualToString:@"T"]){
        maxValue.text=[NSString stringWithFormat:@"Max:%@",[CXMGlobal getStringTemp:self.binSum.maxT.description isUnit:1]];
        minValue.text=[NSString stringWithFormat:@"Min:%@",[CXMGlobal getStringTemp:self.binSum.minT.description isUnit:1]];
        avgValue.text=[NSString stringWithFormat:@"Avg:%@",[CXMGlobal getStringTemp:self.binSum.avgT.description isUnit:1]];
    }else if([dataType isEqualToString:@"M"]){
        maxValue.text=[NSString stringWithFormat:@"Max:%@",[CXMGlobal getStringHum:self.binSum.maxM.description isUnit:1]];
        minValue.text=[NSString stringWithFormat:@"Min:%@",[CXMGlobal getStringHum:self.binSum.minM.description isUnit:1]];
        avgValue.text=[NSString stringWithFormat:@"Avg:%@",[CXMGlobal getStringHum:self.binSum.avgM.description isUnit:1]];
    }else{
        maxValue.text=@"--";
        minValue.text=@"--";
        avgValue.text=@"--";
    }
    
    dataTableController.gatherTime=gatherTime;
    dataTableController.dataType=dataType;
    [dataTableController updateData];
    
    dataChartController.dataType=dataType;
    [dataChartController updateData];
}


-(void)addDataTable{
    if(curController==dataTableController){
        return;
    }else{
        [self fitFrameForChildViewController:dataTableController];
        [self transitionFromOldViewController:curController toNewViewController:dataTableController];
        
    }
}

-(void)addDataChart{
    if(curController==dataChartController){
        return;
    }else{
        [self fitFrameForChildViewController:dataChartController];
        [self transitionFromOldViewController:curController toNewViewController:dataChartController];
       
    }
}

-(void)addSubControllers{
    dataTableController=[[DataTable alloc]initWithNibName:@"SensorDataTable" bundle:nil];
    dataTableController.binSummary=self.binSummary;
    dataTableController.gatherTime=self.binSummary.gatherTime;
    dataTableController.binID=self.binSummary.binID;
    [self addChildViewController:dataTableController];
    
    dataChartController=[[DataChart alloc]initWithNibName:@"SensorDataChart" bundle:nil];
    dataChartController.binSummary=self.binSummary;
    //dataChartController.gatherTime=self.binSummary.gatherTime;
    dataChartController.binID=self.binSummary.binID;
    [self addChildViewController:dataChartController];
    
    [self fitFrameForChildViewController:dataTableController];
    [contentView addSubview:dataTableController.view];
    curController=dataTableController;
    
}

-(void)fitFrameForChildViewController:(UIViewController *)childViewController{
    CGRect frame=contentView.frame;
    frame.origin.y=0;
    [childViewController.view setFrame:frame];
}

-(void)transitionFromOldViewController:(UIViewController *)oldViewController toNewViewController:(UIViewController *)newViewController{
    [self transitionFromViewController:oldViewController toViewController:newViewController duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if(finished){
            [newViewController didMoveToParentViewController:self];
            curController=newViewController;
        }else
            curController=oldViewController;
    }];
}

-(void)removeAllChildViewControllers{
    for(UIViewController *vc in self.childViewControllers){
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
    }
}
@end
