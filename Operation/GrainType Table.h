//
//  GrainType Table.h
//  JC8030
//
//  Created by cxm on 16/6/30.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIkit/UIkit.h"


@interface GrainType_Table : NSObject<UITableViewDataSource,UITableViewDelegate>{
    NSArray *grainTypes;
}
@property(nonatomic,strong)NSString *selectedGrainType;
+(GrainType_Table *)init;
@end
