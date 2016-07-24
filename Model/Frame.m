//
//  Frame.m
//  JC8030
//
//  Created by cxm on 16/7/11.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "Frame.h"

@implementation Frame
-(NSArray *)getFrame{
    length=6+dataArea.count;
    NSMutableArray *noCheckedFrame=[[NSMutableArray alloc]init];
    [noCheckedFrame addObject:@(toAddress)];
    [noCheckedFrame addObject:@(fromAddress)];
    [noCheckedFrame addObject:@(cmd)];
    [noCheckedFrame addObject:@(length)];
    for(int i=0;i<dataArea.count;i++){
        [noCheckedFrame addObject:dataArea[i]];
    }
    NSArray *checkCode=[self crc16:noCheckedFrame];
    [noCheckedFrame addObject:checkCode[0]];
    [noCheckedFrame addObject:checkCode[1]];
    return noCheckedFrame;
}

-(NSArray *)crc16:(NSArray *)noCheckCodeFrame{
    NSMutableArray *checkCode=[[NSMutableArray alloc]initWithCapacity:2];
    int crc=0xffff;
    int crc_gen=0xa001;
    if(noCheckCodeFrame.count!=0){
        for(int i=0;i<noCheckCodeFrame.count;i++){
            crc^=((NSNumber *)noCheckCodeFrame[i]).intValue;
            for(int j=0;j<8;j++){
                if((crc&0x01)!=0){
                    crc>>=1;
                    crc^=crc_gen;
                }else
                    crc>>=1;
            }
        }
    }
    checkCode[0]=@(crc);
    checkCode[1]=@(crc>>8);
    return checkCode;
}
-(NSData *)getCommonFrame:(Byte)toAddr fromAddr:(Byte)fromAddr cmd:(Byte)command dataArea:(NSArray *)dataArea1{
    NSArray *frame=[[NSArray alloc]init];
    toAddress=toAddr;
    fromAddress=fromAddr;
    cmd=command;
    dataArea=dataArea1;
    frame=[self getFrame];
    Byte bytes[frame.count];
    for(int i=0;i<frame.count;i++){
        bytes[i]=(Byte)((NSNumber *)frame[i]).intValue;
        
    }
    
    //NSString *str=[self bytesToHex:bytes length:frame.count];
    //NSLog(@"%@");
    NSData *returnData=[[NSData alloc]initWithBytes:bytes length:frame.count];
    return returnData;
}


//byte数组转16进制字符串
-(NSString *)bytesToHex:(Byte *)bytes length:(long)len{
    NSString *hexStr=@"";
    for(int i=0;i<len;i++){
        NSString *newHexStr=[NSString  stringWithFormat:@"%x",bytes[i]&0xff];
        if([newHexStr length]==1)
            hexStr=[NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr=[NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    //NSLog(@"%@",hexStr);
    return hexStr;
}



















@end
