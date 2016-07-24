//
//  FansPageController.h
//  JC8030
//
//  Created by cxm on 16/7/7.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"

@interface FansPageController : BaseConroller<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *myTableView;
}

@end
