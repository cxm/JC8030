//
//  MoreDataCell.h
//  JC8030
//
//  Created by cxm on 16/7/18.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BinSum.h"
@interface MoreDataCell : UITableViewCell{
    IBOutlet UILabel *labelGatherTime;
    IBOutlet UILabel *labelMax;
    IBOutlet UILabel *labelAvg;
    IBOutlet UILabel *labelMin;
}
-(void)setSum:(BinSum *)binSum;
@end
