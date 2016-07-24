//
//  MoreSensorDataController.h
//  JC8030
//
//  Created by cxm on 16/7/18.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"
#import "BinSum.h"
@protocol updataDelegate<NSObject>
-(void)updataWithTime:(NSString *)gatherTime binSum:(BinSum *)binSum;
@end
@protocol updataDelegate;
@interface MoreSensorDataController : BaseConroller<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITextField *textStart;
    IBOutlet UITextField *textEnd;
    IBOutlet UITableView *myTableView;
}
@property(nonatomic,strong)id<updataDelegate> updataDelegate;
@end
