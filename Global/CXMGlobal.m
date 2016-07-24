//
//  CXMGlobal.m
//  JC8030
//
//  Created by cxm on 16/6/30.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "CXMGlobal.h"
#import "PlistOperation.h"


@implementation CXMGlobal

+(NSString *)getStationPhoneNumber{
    NSString *phoneNumber;
    NSMutableDictionary *plist=[PlistOperation readPlistToDictionary:AppSettingFile withPoint:@"Station"];
    phoneNumber=[plist valueForKey:@"Phone Number"];
    return phoneNumber;
}

+(void) setStationPhoneNumber:(NSString *)phoneNumber{
    NSMutableDictionary *station=[[NSMutableDictionary alloc]init];
    [station setValue:phoneNumber forKey:@"Phone Number"];
    [PlistOperation updatePlistByDictionary:AppSettingFile withPoint:@"Station" andContent:station];
}

+(NSString *)getTemperatureUnit{
    NSString *unit;
    NSMutableDictionary *plist=[PlistOperation readPlistToDictionary:AppSettingFile withPoint:@"Temperature Units"];
    for(NSString *key in plist){
        if([plist[key] intValue]==1)
            unit=key;
    }
    return unit;
}

+(void)setTemperatureUnit:(NSString *)unit{
    NSMutableDictionary *temperature=[[NSMutableDictionary alloc]init];
    [temperature setValue:@(1) forKey:unit];
    [PlistOperation updatePlistByDictionary:AppSettingFile withPoint:@"Temperature Units" andContent:temperature];
}

+(NSString *)getWeightUnit{
    NSString *unit;
    NSMutableDictionary *plist=[PlistOperation readPlistToDictionary:AppSettingFile withPoint:@"Weight Units"];
    for(NSString *key in plist){
        if([plist[key] intValue]==1)
            unit=key;
    }
    return unit;
}

+(void)setWeightUnit:(NSString *)unit{
    NSMutableDictionary *weight=[[NSMutableDictionary alloc]init];
    [weight setValue:@(1) forKey:unit];
    [PlistOperation updatePlistByDictionary:AppSettingFile withPoint:@"Weight Units" andContent:weight];
}

+(NSString *)getCurrentDateTime{
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *dateString=[dateFormatter stringFromDate:date];
    return dateString;
}

+(NSString *)getTemp:(int)temp{
    NSString *str;
    if(temp==0x0fff||temp==0x0550)
        str=@"--";
    else{
        double d;
        if(temp>=2048){
            temp=4096-temp;
            d=-temp/16.0;
        }else
            d=temp/16.0;
        str=[NSString stringWithFormat:@"%.1f",d];
    }
    return str;
}

+(NSString *)getHum:(int)hum{
    NSString *str;
    if(hum==0x0fff){
        str=@"--";
    }else{
        str=[NSString stringWithFormat:@"%d",hum];
    }
    return str;
}

//格式划小数 四舍五入类型
+ (NSNumber *) decimalwithFormat:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
   
    [numberFormatter setPositiveFormat:@"0.0"];
    
    NSString *str=[numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
    //NSLog(@"%@",str);
    
    return [numberFormatter numberFromString:str];
}


+(float)getFloatTempNoUnit:(float)temp{
    NSString *tUnit=[self getTemperatureUnit];
    if([tUnit isEqualToString:@"℉"]){
        float t=temp;
        t=t*1.8+32;
        return [self decimalwithFormat:t].floatValue;
    }else{
        return temp;
    }
}

+(NSString *)getStringTemp:(NSString *)temp isUnit:(int)isUnit{
    if([temp isEqualToString:@"--"])
        return temp;
    NSString *str;
    str=[NSString stringWithFormat:@"%.1f",[self getFloatTempNoUnit:temp.floatValue]];
    if(isUnit==1)
        str=[str stringByAppendingString:[self getTemperatureUnit]];
    return str;
}

+(NSString *)getStringHum:(NSString *)hum isUnit:(int)isUnit{
    NSString *str;
    if(hum.intValue==-100||[hum isEqualToString:@"--"]){
        str=@"--";
    }else
        str=hum;
    if(isUnit==1)
        str=[str stringByAppendingString:@"%"];
    return str;
}

+(void) fileIsExist:(NSString *)fileName{
    NSString *documentsDirectory=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *filePath=[documentsDirectory stringByAppendingPathComponent:fileName];
    if(![fileManager fileExistsAtPath:filePath]){
        NSLog(@"%@ is not exist",fileName);
        NSString *customPath=[[NSBundle mainBundle]pathForResource:@"sqlData" ofType:@"bundle"];
        NSString *dataPath=[[[NSBundle bundleWithPath:customPath]bundlePath]stringByAppendingPathComponent:fileName];
        NSError *error;
        if([fileManager copyItemAtPath:dataPath toPath:filePath error:&error]){
            NSLog(@"copy %@ success",fileName);
        }
        else{
            NSLog(@"%@",error);
        }
    }
}

+(void) okAlertFromController:(UIViewController *)controller message:(NSString *)message btnTitle:(NSString *)btnTitle{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    //添加按钮
    [alert addAction:ok];
    //以modal的方式来弹出
    [controller presentViewController:alert animated:YES completion:^{ }];

}

+(void)toastWithContent:(NSString *)content time:(int)time controllerView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = content;
    // Move to bottm center.
    //hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:1.f];

}

+(UIColor*)getColorWithTemp:(NSString *)temp highAlarm:(NSString *)highAlarm{
    UIColor *color=[UIColor clearColor];
    if([temp isEqualToString:@""]||[temp isEqualToString:@"--"])
        color=[UIColor clearColor];
    float tempData=temp.floatValue;
    if([highAlarm isEqualToString:@""])
        return [UIColor clearColor];
    float highAlarmValue=highAlarm.floatValue;
    if(tempData<=-10)
        //color= Color.rgb(17, 55, 249);
        color=[UIColor colorWithRed:17/255.0 green:55/255.0 blue:249/255.0 alpha:1];
    else if(tempData>-10&&tempData<=0)
        //color=Color.rgb(20,198,255);
        color=[UIColor colorWithRed:20/255.0 green:198/255.0 blue:255/255.0 alpha:1];
    else if(tempData>0&&tempData<=10)
        color=[UIColor colorWithRed:34/255.0 green:139/255.0 blue:34/255.0 alpha:1];
        //color=Color.rgb(34,139,34);
    else if(tempData>10&&tempData<=20)
        color=[UIColor colorWithRed:0/255.0 green:201/255.0 blue:87/255.0 alpha:1];
        //color=Color.rgb(0,201,87);
    else if(tempData>20&&tempData<=25)
        color=[UIColor colorWithRed:127/255.0 green:255/255.0 blue:0/255.0 alpha:1];
        //color=Color.rgb(127,255,0);
    else if(tempData>25&&tempData<=30)
        color=[UIColor colorWithRed:255/255.0 green:153/255.0 blue:18/255.0 alpha:1];
        //color=Color.rgb(255,153,18);
    else
        color=[UIColor colorWithRed:255/255.0 green:97/255.0 blue:0/255.0 alpha:1];
        //color=Color.rgb(255,97,0);
    
    if(tempData<-20||tempData>60)
        color=[UIColor colorWithRed:114/255.0 green:114/255.0 blue:114/255.0 alpha:1];
        //color=Color.rgb(114, 114, 114);
    if(tempData>highAlarmValue)
        color=[UIColor colorWithRed:219/255.0 green:21/255.0 blue:0/255.0 alpha:1];
        //color=Color.rgb(219,21,0);
    return color;
}










@end
