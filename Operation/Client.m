//
//  Client.m
//  JC8030
//
//  Created by cxm on 16/7/11.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "Client.h"
#import "FrameOperation.h"

@implementation Client
singleton_implementation(Client)

-(id)init{
    if(self=[super init]){
        IP=@"192.168.0.107";
        Port=@"6800";
        clientSocket=[[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}

-(void)connectToHost{
    if(![clientSocket isConnected]){
        NSError *error=nil;
        [clientSocket connectToHost:IP onPort:Port.intValue withTimeout:1 error:&error];
        if(error){
            NSLog(@"connect error:%@",error);
            [clientSocket disconnect];
        }
    }
}

-(void)sendData:(NSData *)datas{
    [self connectToHost];
    [clientSocket writeData:datas withTimeout:3 tag:2];
}

#pragma mark delegate
/**
 * Called when a socket connects and is ready for reading and writing.
 * The host parameter will be an IP address, not a DNS name.
 **/
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"coneect success");
    [clientSocket readDataWithTimeout:-1 buffer:buffer bufferOffset:0 tag:5];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"net" object:self userInfo:@{@"connect":@"success"}];
}


/**
 * Called when a socket has completed reading the requested data into memory.
 * Not called if there is an error.
 **/
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    const Byte *bytes=[data bytes];
    for(int i=0;i<[data length];i++){
        NSLog(@"%@",[NSString stringWithFormat:@"%X",bytes[i]]);
    }
//  NSLog(@"%lu",(unsigned long)[data length]);
    [[FrameOperation sharedFrameOperation]frameDecode:data];
    [clientSocket readDataWithTimeout:-1 buffer:buffer bufferOffset:0 tag:5];
}


/**
 * Called when a socket has completed writing the requested data. Not called if there is an error.
 **/
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"send data success");
    [clientSocket readDataWithTimeout:2 buffer:buffer bufferOffset:0 tag:5];
}


/**
 * Conditionally called if the read stream closes, but the write stream may still be writeable.
 *
 * This delegate method is only called if autoDisconnectOnClosedReadStream has been set to NO.
 * See the discussion on the autoDisconnectOnClosedReadStream method for more information.
 **/
- (void)socketDidCloseReadStream:(GCDAsyncSocket *)sock{
    
}

/**
 * Called when a socket disconnects with or without error.
 *
 * If you call the disconnect method, and the socket wasn't already disconnected,
 * then an invocation of this delegate method will be enqueued on the delegateQueue
 * before the disconnect method returns.
 *
 * Note: If the GCDAsyncSocket instance is deallocated while it is still connected,
 * and the delegate is not also deallocated, then this method will be invoked,
 * but the sock parameter will be nil. (It must necessarily be nil since it is no longer available.)
 * This is a generally rare, but is possible if one writes code like this:
 *
 * asyncSocket = nil; // I'm implicitly disconnecting the socket
 *
 * In this case it may preferrable to nil the delegate beforehand, like this:
 *
 * asyncSocket.delegate = nil; // Don't invoke my delegate method
 * asyncSocket = nil; // I'm implicitly disconnecting the socket
 *
 * Of course, this depends on how your state machine is configured.
 **/
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err{
    NSLog(@"disconnect");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"net" object:self userInfo:@{@"connect":@"failed"}];
}


@end
