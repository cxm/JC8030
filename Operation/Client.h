//
//  Client.h
//  JC8030
//
//  Created by cxm on 16/7/11.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "Singleton.h"
@interface Client : NSObject<GCDAsyncSocketDelegate>{
    NSString *IP;
    NSString *Port;
    GCDAsyncSocket *clientSocket;
    NSMutableData *buffer;
}
singleton_interface(Client)
-(id)init;
-(void)connectToHost;
-(void)sendData:(NSData *)datas;
@end
