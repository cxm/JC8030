//
//  Frame.h
//  JC8030
//
//  Created by cxm on 16/7/11.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Frame : NSObject{
    Byte toAddress;
    Byte fromAddress;
    Byte cmd;
    Byte length;
    NSArray *dataArea;
}
-(NSData *)getCommonFrame:(Byte)toAddr fromAddr:(Byte)fromAddr cmd:(Byte)cmd dataArea:(NSArray *)dataArea;
@end
