//
//  BinOperation.h
//  JC8030
//
//  Created by cxm on 16/7/3.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bin.h"
#import "Singleton.h"

@interface BinOperation : NSObject
singleton_interface(BinOperation)
-(BOOL) addBin:(Bin *)bin;
-(BOOL) modifyBin:(Bin *)bin;
-(Bin *) getBinByID:(NSNumber *)ID;
-(Bin *)getBinByStation:(NSNumber *)stationID;
-(BOOL)removeBin:(NSNumber *)ID;
-(Bin *)getbinByName:(NSString *)binName;
-(NSArray *)getAllBin;
@end
