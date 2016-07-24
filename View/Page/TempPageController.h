//
//  TempPageController.h
//  JC8030
//
//  Created by cxm on 16/7/7.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"
#import "DataTable.h"
#import "DataChart.h"
#import "DTStatusView.h"
#import "BinSum.h"

@interface TempPageController : BaseConroller<DTStatusViewDelegate>{
    IBOutlet UIView *contentView;
    DataChart *dataChartController;
    NSString *gatherTime;
    DataTable *dataTableController;
    UIViewController *curController;
    IBOutlet DTStatusView *tabView;
    IBOutlet UILabel *maxValue;
    IBOutlet UILabel *avgValue;
    IBOutlet UILabel *minValue;
    IBOutlet UILabel *labelLastUpdate;
}
@property(nonatomic,copy) NSString *labelGatherTime;
@property(nonatomic,copy)NSString *flag;
@property(nonatomic,strong)BinSum *binSum;
-(void)setData;
@end
