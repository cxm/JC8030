//
//  FrameOperation.h
//  JC8030
//
//  Created by cxm on 16/7/11.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface FrameOperation : NSObject{
    Byte *frameBytes;
    NSMutableData *gatherFrame;//温湿度数据包
    int dataSize;
    int frameNo;
    int stationID;
}
singleton_interface(FrameOperation)
@property(nonatomic,strong)NSMutableData *buffer;//接收到数据包
-(void)frameDecode:(NSData *)frame;
-(id)init;
@end
