
//
//  Define.h
//  JC8030
//
//  Created by cxm on 16/6/19.
//  Copyright © 2016年 cxm. All rights reserved.
//

#ifndef Define_h
#define Define_h

#pragma mark 数据库名称定义
#define DatabaseName @"grain.db"

#define AppSettingFile @"SystemSettings.plist"

//数据包命令
#define cmd_gather 0x11
#define cmd_control 0x12
#define cmd_his 0x21
#define address_main 0x01
#define address_user 0xFE
#define address_broad 0xFF


//系统版本
#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0

#endif /* Define_h */
