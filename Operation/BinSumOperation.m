//
//  BinSumOperation.m
//  JC8030
//
//  Created by cxm on 16/7/6.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BinSumOperation.h"
#import "DbManager.h"

@implementation BinSumOperation
singleton_implementation(BinSumOperation)
-(BOOL)addBinSum:(BinSum *)binSum{
    NSString *sql=[NSString stringWithFormat:@"insert into BinSum (gatherTime,binID,layer,maxT,minT,avgT,maxM,minM,avgM) values (?,?,?,?,?,?,?,?,?)"];
    NSArray *arguments=@[binSum.gatherTime,binSum.binID,binSum.layer,binSum.maxT,binSum.minT,binSum.avgT,binSum.maxM,binSum.minM,binSum.avgM];
    return [[DbManager sharedDbManager] executeNonQuery:sql withArguments:arguments];
}

-(BinSum *)getLastSumByBinID:(NSNumber *)binID layer:(NSNumber *)layer{
    BinSum * binSum=[[BinSum alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM BinSum WHERE binID=? and layer=? order by gatherTime desc limit 1"];
    NSArray *arguments=@[binID,layer];
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:arguments];
    if (rows&&rows.count>0) {
        [binSum setValuesForKeysWithDictionary:rows[0]];
    }
    return binSum;
}

-(NSArray *)getAllSumByBinID:(NSNumber *)binID layer:(NSNumber *)layer startDate:(NSString *)start endDate:(NSString *)end{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM BinSum WHERE binID=? and layer=? order by gatherTime limit 1"];
    NSArray *arguments;
    if(start==nil||end==nil||start.length==0||end.length==0){
        sql=[NSString stringWithFormat:@"SELECT * FROM BinSum WHERE binID=? and layer=? order by gatherTime desc"];
        arguments=@[binID,layer];
    }else{
        sql=[NSString stringWithFormat:@"SELECT * FROM BinSum WHERE gatherTime between ? and ? and binID=? and layer=? order by gatherTime desc "];
        arguments=@[start,end,binID,layer];
    }
    NSArray *rows= [[DbManager sharedDbManager] executeQuery:sql withArguments:arguments];
    if (rows&&rows.count>0) {
        BinSum *binSum;
        for(int i=0;i<rows.count;i++){
            binSum=[[BinSum alloc]initWithDictionary:rows[i]];
            [array addObject:binSum];
        }
    }
    return array;
}
@end
