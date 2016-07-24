//
//  DataTable.h
//  JC8030
//
//  Created by cxm on 16/7/9.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"
#import "XCMultiSortTableView.h"
@protocol updataDelegate;
@interface DataTable : BaseConroller<updataDelegate>{
    NSMutableArray *sensorDatas;
    NSMutableArray *cableList;
    int maxLayers;
}
@property(nonatomic,copy)NSString *dataType;
@property(nonatomic,copy)NSString *gatherTime;
-(void)updateData;
@end
