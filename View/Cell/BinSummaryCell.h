//
//  BinSummaryCell.h
//  JC8030
//
//  Created by cxm on 16/7/6.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BinSummary.h"

@interface BinSummaryCell : UITableViewCell{
    IBOutlet UILabel *labelBinName;
    IBOutlet UILabel *labelGrainType;
    IBOutlet UILabel *labelAvg;
    IBOutlet UILabel *labelLevel;
    IBOutlet UIImageView *imageViewBin;
}
-(void)setSummary:(BinSummary *)binSummary;
@end
