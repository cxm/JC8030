//
//  PlistOperation.m
//  JC8030
//
//  Created by cxm on 16/6/29.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "PlistOperation.h"

@implementation PlistOperation

+(void) fileIsExist:(NSString *)fileName{
    NSString *documentsDirectory=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *filePath=[documentsDirectory stringByAppendingPathComponent:fileName];
    if(![fileManager fileExistsAtPath:filePath]){
        NSLog(@"%@ is not exist",fileName);
        NSString *dataPath=[[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:fileName];
        NSError *error;
        if([fileManager copyItemAtPath:dataPath toPath:filePath error:&error]){
            NSLog(@"copy %@ success",fileName);
        }
        else{
            NSLog(@"%@",error);
        }
    }
}

+(NSMutableDictionary *) readPlistToDictionary:(NSString *)fileName withPoint:(NSString *)point{
    NSMutableDictionary *returnData=[[NSMutableDictionary alloc]init];
    NSString *documentsDirectory=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath=[documentsDirectory stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:filePath]){
        NSMutableDictionary *data=[[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
        if(point==nil||point==NULL)
            returnData=data;
        else
            returnData=[data objectForKey:point];
    }
    return returnData;
}

+(BOOL) updatePlistByDictionary:(NSString *)fileName withPoint:(NSString *)point andContent:(NSMutableDictionary *)data{
    NSString *documentsDirectory=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath=[documentsDirectory stringByAppendingPathComponent:fileName];
    NSMutableDictionary *allData=[self readPlistToDictionary:fileName withPoint:nil];
    NSMutableDictionary *pointData=allData[point];
    for(NSString *key in data){
        [pointData setValue:data[key] forKey:key];
    }
    [allData setValue:data forKey:point];
    return [allData writeToFile:filePath atomically:YES];
}
@end
