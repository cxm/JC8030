//
//  AmibentCell.h
//  JC8030
//
//  Created by cxm on 16/7/17.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AmibentCell : UITableViewCell{
    IBOutlet UILabel *ambientLabel;
}
-(void)setAmbient:(NSString *)ambient;
@end
