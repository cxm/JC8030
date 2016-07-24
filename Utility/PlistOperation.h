//
//  PlistOperation.h
//  JC8030
//  Plist文件操作
//  Created by cxm on 16/6/29.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistOperation : NSObject

#pragma mark 判断一个plist文件在沙盒中是否存在，不存在则从程序包中拷贝
+(void) fileIsExist:(NSString *) fileName;

#pragma mark 读取Plist文件以字典方式存储
+(NSMutableDictionary *) readPlistToDictionary:(NSString *)fileName withPoint:(NSString *)point;

#pragma mark 修改Plist文件以字典方式
+(BOOL) updatePlistByDictionary:(NSString *)fileName withPoint:(NSString *)point andContent:(NSMutableDictionary *)data;
@end
