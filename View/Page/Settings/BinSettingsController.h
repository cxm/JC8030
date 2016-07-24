//
//  BinSettingsController.h
//  JC8030
//
//  Created by cxm on 16/6/22.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"

@interface BinSettingsController : BaseConroller{
IBOutlet UIControl * addNewBinView;
}
-(IBAction)addNewBin:(id)sender;
@end
