//
//  CXMGlobal.h
//  JC8030
//
//  Created by cxm on 16/6/30.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CXMGlobal : NSObject
+(NSString *)getStationPhoneNumber;
+(void)setStationPhoneNumber:(NSString *)phoneNumber;
+(NSString *)getTemperatureUnit;
+(void)setTemperatureUnit:(NSString *)unit;
+(NSString *)getWeightUnit;
+(void)setWeightUnit:(NSString *)unit;

//获取当前时间
+(NSString *)getCurrentDateTime;

+(NSString *)getTemp:(int)temp;
+(NSString *)getHum:(int)hum;


+ (NSNumber *) decimalwithFormat:(float)floatV;
+(float)getFloatTempNoUnit:(float)temp;
+(NSString *)getStringTemp:(NSString *)temp isUnit:(int)isUnit;
+(NSString *)getStringHum:(NSString *)hum isUnit:(int)isUnit;

+(void) fileIsExist:(NSString *)fileName;

//弹出框
+(void) okAlertFromController:(UIViewController *)controller message:(NSString *)message btnTitle:(NSString *)btnTitle;


//toast
+(void)toastWithContent:(NSString *)content time:(int)time controllerView:(UIView *)view;

+(UIColor*)getColorWithTemp:(NSString *)temp highAlarm:(NSString *)highAlarm;
@end
