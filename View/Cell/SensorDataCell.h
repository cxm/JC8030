//
//  SensorDataCell.h
//  JC8030
//
//  Created by cxm on 16/7/10.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SensorDataCell : UITableViewCell{
    
}
-(void)setSensorData:(int)layer sensorDatas:(NSArray *)sensorDatas cables:(NSArray *)cables dataType:(NSString *)dataType;
@end
