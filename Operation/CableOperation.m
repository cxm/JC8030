//
//  CableOperation.m
//  JC8030
//
//  Created by cxm on 16/7/5.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "CableOperation.h"
#import "DbManager.h"

@implementation CableOperation
singleton_implementation(CableOperation)

-(BOOL)addCable:(Cable *)cable{
    NSString *sql=[NSString stringWithFormat:@"insert into Cable (binID,cableNumber,cableType,createdAt,sensorCounts,mCounts,radius,rotation,removed,sensorSpacing,updatedAt) values (?,?,?,?,?,?,?,?,?,?,?)"];
    NSArray *arguments=@[cable.binID,cable.cableNumber,cable.cableType,cable.createdAt,cable.sensorCounts,cable.mCounts,cable.radius,cable.rotation,cable.removed,cable.sensorSpacing,cable.updatedAt];
    return [[DbManager sharedDbManager] executeNonQuery:sql withArguments:arguments];
}

-(void)modifyCable:(Cable *)cable{
    NSString *sql=[NSString stringWithFormat:@"update Cable set binID=?,cableNumber=?,cableType=?,createdAt=?,sensorCounts=?,mCounts=?,radius=?,rotation=?,removed=?,sensorSpacing=?,updatedAt=? where ID=?"];
    NSArray *arguments=@[cable.binID,cable.cableNumber,cable.cableType,cable.createdAt,cable.sensorCounts,cable.mCounts,cable.radius,cable.rotation,cable.removed,cable.sensorSpacing,cable.updatedAt,cable.ID];
    [[DbManager sharedDbManager] executeNonQuery:sql withArguments:arguments];
}

-(NSMutableArray *)getCablesByBinID:(NSNumber *)binID{
    NSMutableArray *cableArray=[[NSMutableArray alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM Cable WHERE binID=?"];
    if(binID==nil)
        return cableArray;
    NSArray *arguments=@[binID];
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:arguments];
    if (rows&&rows.count>0) {
        for(NSDictionary *dic in rows){
            Cable *cable=[[Cable alloc]init];
            [cable setValuesForKeysWithDictionary:dic];
            [cableArray addObject:cable];
        }
    }
    return cableArray;
}

-(Cable *)getCableByID:(NSNumber *)ID{
    Cable *cable=[[Cable alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM Cable WHERE ID=?"];
    NSArray *arguments=@[ID];
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:arguments];
    if (rows&&rows.count>0) {
        [cable setValuesForKeysWithDictionary:rows[0]];
    }
    return cable;
}

-(void)removeCable:(NSNumber *)ID{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM Cable WHERE ID=?"];
    NSArray *arguments=@[ID];
    [[DbManager sharedDbManager] executeNonQuery:sql withArguments:arguments];
}

-(NSArray *)getSensorCounts:(NSNumber *)binID{
    NSArray *cableList=[self getCablesByBinID:binID];
    NSMutableArray *sensorCounts=[[NSMutableArray alloc]init];
    int tCounts=0;
    int mCoutns=0;
    for(Cable * cable in cableList){
        tCounts+=cable.sensorCounts.intValue;
        mCoutns+=cable.mCounts.intValue;
    }
    [sensorCounts addObject:@(tCounts)];
    [sensorCounts addObject:@(mCoutns)];
    return sensorCounts;
}
@end
