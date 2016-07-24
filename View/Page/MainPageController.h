//
//  MainPageController.h
//  JC8030
//
//  Created by cxm on 16/6/17.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"

@interface MainPageController : BaseConroller<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UIButton * addNewBin;
    IBOutlet UITableView *myTableView;
    NSMutableArray *binSummarys;
    
}

@end
