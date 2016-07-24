//
//  Temperature Unit Table.h
//  JC8030
//
//  Created by cxm on 16/6/30.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIkit.h"
@interface Unit_Table : NSObject<UITableViewDataSource,UITableViewDelegate>{
    NSMutableDictionary *settingsData;
    NSArray *keys;
    NSArray *values;
    NSIndexPath *selectedIndex;
    NSString *unitsOfSettings;
}
-(void)readSettings;
-(void)saveSettings;
+(Unit_Table*)initWithUnits:(NSString *)units;
@end
