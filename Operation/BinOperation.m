//
//  BinOperation.m
//  JC8030
//
//  Created by cxm on 16/7/3.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BinOperation.h"
#import "Dbmanager.h"

@implementation BinOperation
singleton_implementation(BinOperation)
-(BOOL) addBin:(Bin *)bin{
    NSString *sql=[NSString stringWithFormat:@"insert into Bin (binType,binName,stationID,grainType,level,bushels,totalCapacity,fillDate,createdAt,updatedAt,removed,binImage) values (?,?,?,?,?,?,?,?,?,?,?,?)"];
    NSArray *arguments=@[bin.binType,bin.binName,bin.stationID,bin.grainType,bin.level,bin.bushels,bin.totalCapacity,bin.fillDate,bin.createdAt,bin.updatedAt,bin.removed,bin.binImage];
    return [[DbManager sharedDbManager] executeNonQuery:sql withArguments:arguments];
}

-(BOOL) modifyBin:(Bin *)bin{
    NSString *sql=[NSString stringWithFormat:@"update Bin set binType=?,binName=?,stationID=?,grainType=?,level=?,bushels=?,totalCapacity=?,fillDate=?,createdAt=?,updatedAt=?,removed=?,binImage=? where ID=?"];
    NSArray *arguments=@[bin.binType,bin.binName,bin.stationID,bin.grainType,bin.level,bin.bushels,bin.totalCapacity,bin.fillDate,bin.createdAt,bin.updatedAt,bin.removed,bin.binImage,bin.ID];
    return [[DbManager sharedDbManager] executeNonQuery:sql withArguments:arguments];
}
-(BOOL)removeBin:(NSNumber *)ID{
    NSString *sql=[NSString stringWithFormat:@"delete from Bin where ID=?"];
    NSArray *arguments=@[ID];
    return [[DbManager sharedDbManager] executeNonQuery:sql withArguments:arguments];
}
-(Bin *)getBinByID:(NSNumber *)ID{
    Bin * bin=[[Bin alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT ID,binType,binName,stationID,grainType,level,bushels,totalCapacity,fillDate,createdAt,updatedAt,removed,binImage FROM Bin WHERE ID=?"];
    NSArray *argumnents=@[ID];
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:argumnents];
    if (rows&&rows.count>0) {
        [bin setValuesForKeysWithDictionary:rows[0]];
        return bin;
    }else
        return nil;
}

-(Bin *)getBinByStation:(NSNumber *)stationID{
    Bin * bin=[[Bin alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT ID,binType,binName,stationID,grainType,level,bushels,totalCapacity,fillDate,createdAt,updatedAt,removed,binImage FROM Bin WHERE stationID=?"];
    NSArray *argumnents=@[stationID];
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:argumnents];
    if (rows&&rows.count>0) {
        [bin setValuesForKeysWithDictionary:rows[0]];
        return bin;
    }else
        return nil;
    
}

-(Bin *)getbinByName:(NSString *)binName{
    Bin * bin=[[Bin alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT ID,binType,binName,stationID,grainType,level,bushels,totalCapacity,fillDate,createdAt,updatedAt,removed,binImage FROM Bin WHERE binName=?"];
    NSArray *argumnents=@[binName];
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:argumnents];
    if (rows&&rows.count>0) {
        [bin setValuesForKeysWithDictionary:rows[0]];
        return bin;
    }
    return nil;
}

-(NSArray *)getAllBin{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT ID,binType,binName,stationID,grainType,level,bushels,totalCapacity,fillDate,createdAt,updatedAt,removed,binImage FROM Bin"];
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:NULL];
    for(int i=0;i<rows.count;i++){
        Bin * bin=[[Bin alloc]init];
        [bin setValuesForKeysWithDictionary:rows[i]];
        NSLog(@"%@",bin.binName);
        //NSLog(@"%lu",(unsigned long)bin.binImage.length);
        [array addObject:bin];
    }
    return array;
}
@end
