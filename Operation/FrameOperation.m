//
//  FrameOperation.m
//  JC8030
//
//  Created by cxm on 16/7/11.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "FrameOperation.h"
#import "SensorDataOperation.h"
#import "BinOperation.h"
#import "CableOperation.h"
#import "BinSumOperation.h"
#import "FanRecordOperation.h"
#import "FanOperation.h"

@implementation FrameOperation
singleton_implementation(FrameOperation)
-(id)init{
    if(self=[super init]){
        frameNo=-1;
        stationID=-1;
        dataSize=0;
    }
    return self;
}
-(void)frameDecode:(NSData *)frame{
    if(self.buffer==nil)
        self.buffer=[[NSMutableData alloc]init];
    [self.buffer appendData:frame];
    Byte *bytes=(Byte *)[self.buffer bytes];
    if([self.buffer length]>6){
        Byte len=bytes[3];//数据包长度
        if([self.buffer length]==len){
            NSData *tempBuffer=self.buffer;
            self.buffer=nil;//清空buffer
            Byte cmd=bytes[2];
            if(cmd==cmd_control){
                frameBytes=bytes;
                [self controlFrameDecode];
                return;
            }
            if(cmd==cmd_gather){
                int size=bytes[4]&0x0f;//总包数
                int no=(bytes[4]&0xf0)>>4;//包序号
                if(no==0||size==0){
                    //点数配置错误 发送通知
                    return;
                }
                
                if(frameNo==no) return;//?
                frameNo=no;
                if(stationID!=-1&&bytes[1]!=stationID){
                    dataSize=0;
                    stationID=-1;
                    frameNo=-1;
                    return;
                }
                //第一包和只有一包
                if(dataSize==0||stationID==-1){
                    dataSize=size;
                    stationID=bytes[1];
                    if(gatherFrame==nil)
                        gatherFrame=[[NSMutableData alloc]init];
                    if(dataSize==no){//只有一包
                        [gatherFrame appendData:tempBuffer];
                        dataSize=0;
                        stationID=-1;
                        frameNo=-1;
                        [self gatherFrameDecode];
                        return;
                    }else{//数据多包 第一包
                        [gatherFrame appendData:[tempBuffer subdataWithRange:NSMakeRange(0, [tempBuffer length]-2)]];
                        return;
                    }
                }else if(dataSize==no){//最后一包
                    dataSize=0;
                    stationID=-1;
                    frameNo=-1;
                    [gatherFrame appendData:[tempBuffer subdataWithRange:NSMakeRange(5, [tempBuffer length]-5)]];
                    [self gatherFrameDecode];
                    return;
                }else{//中间包
                    [gatherFrame appendData:[tempBuffer subdataWithRange:NSMakeRange(5, [tempBuffer length]-7)]];
                    return;
                }
            }
        }
    }
}

//采集命令解析
-(void)gatherFrameDecode{
    NSString *temp=@"";
    NSString *hum=@"";
    NSString *sTemp;
    SensorData *sensorData;
    NSMutableArray *sensorDatas=[[NSMutableArray alloc]init];
    int intValue=0;
    Byte *fBytes=(Byte *)gatherFrame.bytes;
    int frameLength=gatherFrame.length;
    
    NSString *gatherTime=[CXMGlobal getCurrentDateTime];
    Bin *bin=[[BinOperation sharedBinOperation]getBinByStation:@(fBytes[1])];
    if(bin==nil){}
    for(int i=0;i<frameLength;i++){
        NSLog(@"frame:%@",[NSString stringWithFormat:@"%X",fBytes[i]]);
    }
    //顶温湿 7 8 9
    sTemp=[CXMGlobal getTemp:(((int)fBytes[7]<<4)+((fBytes[8]&0xf0)>>4))];
    temp=[temp stringByAppendingString:sTemp];
    intValue=(((int)fBytes[8]&0x0f)<<8)+fBytes[9];
    if([sTemp isEqualToString:@"--"])
        hum=[hum stringByAppendingString:@"--"];
    else
        hum=[hum stringByAppendingString:[CXMGlobal getHum:intValue]];
    //底温湿 10 11 12
    sTemp=[CXMGlobal getTemp:(((int)fBytes[10]<<4)+((fBytes[11]&0xf0)>>4))];
    temp=[temp stringByAppendingString:@","];
    temp=[temp stringByAppendingString:sTemp];
    intValue=(((int)fBytes[11]&0x0f)<<8)+fBytes[12];
    hum=[hum stringByAppendingString:@","];
    if([sTemp isEqualToString:@"--"])
        hum=[hum stringByAppendingString:@"--"];
    else{
        hum=[hum stringByAppendingString:[CXMGlobal getHum:intValue]];
    }
    //外温湿 13 14 15
    sTemp=[CXMGlobal getTemp:(((int)fBytes[13]<<4)+((fBytes[14]&0xf0)>>4))];
    temp=[temp stringByAppendingString:@","];
    temp=[temp stringByAppendingString:sTemp];
    intValue=(((int)fBytes[14]&0x0f)<<8)+fBytes[15];
    hum=[hum stringByAppendingString:@","];
    if([sTemp isEqualToString:@"--"])
        hum=[hum stringByAppendingString:@"--"];
    else{
        hum=[hum stringByAppendingString:[CXMGlobal getHum:intValue]];
    }
    sensorData=[SensorData sensorDataWithID:@(0) gatherTime:gatherTime binID:bin.ID cableType:@"O" cableNumber:@(0) temp:temp hum:hum];
    [[SensorDataOperation sharedSensorDataOperation]addSenorData:sensorData];
    //通知环境温湿度更新
    
    //[[NSNotificationCenter defaultCenter]postNotification:gatherMsg];
    //粮温
    temp=@"";
    NSArray *cableList=[[CableOperation sharedCableOperation]getCablesByBinID:bin.ID];
    if(cableList==nil||cableList.count==0){
        //传感器未配置
        return;
    }
    int tSensors=0;
    int mSensors=0;
    for(Cable *cable in cableList){
        tSensors+=cable.sensorCounts.intValue;
        mSensors+=cable.mCounts.intValue;
    }
    //所有粮温数据
    if(frameLength>18){
        for(int i=16;i<=16+3*(tSensors/2);i+=3){
            intValue=(((int)fBytes[i]<<4)+((fBytes[i+1]&0xf0)>>4));
            temp=[temp stringByAppendingString:[CXMGlobal getTemp:intValue]];
            temp=[temp stringByAppendingString:@","];
            intValue=(((int)fBytes[i+1]&0x0f)<<8)+fBytes[i+2];
            temp=[temp stringByAppendingString:[CXMGlobal getTemp:intValue]];
            temp=[temp stringByAppendingString:@","];
        }
    }else{
        //数据错误
        return;
    }
    NSArray *strArray=[temp componentsSeparatedByString:@","];
    int i=0;
    int maxLayers=0;
    for(Cable *cable in cableList){
        temp=@"";
        if(cable.sensorCounts.intValue>maxLayers)
            maxLayers=cable.sensorCounts.intValue;
        for(int j=0;j<cable.sensorCounts.intValue;j++){
            temp=[temp stringByAppendingString:strArray[i]];
            if(j<cable.sensorCounts.intValue-1){
                temp=[temp stringByAppendingString:@","];
            }
            i++;
        }
        sensorData=[SensorData sensorDataWithID:@(0) gatherTime:gatherTime binID:bin.ID cableType:cable.cableType cableNumber:cable.cableNumber temp:temp hum:@""];
        [sensorDatas addObject:sensorData];
        [[SensorDataOperation sharedSensorDataOperation]addSenorData:sensorData];
    }
    //温湿度汇总
    [self sumSensorData:sensorDatas maxLayers:maxLayers];
    gatherFrame=nil;
    //通知数据更新
    NSDictionary *dic=@{@"gather":@"success"};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"gather" object:self userInfo:dic];
}
-(void)sumSensorData:(NSArray *)sensorDatas maxLayers:(int)maxLayers {
    NSMutableArray *tempArray=[[NSMutableArray alloc]init];
    int binID=((SensorData *)sensorDatas[0]).binID.intValue;
    NSString *gatherTime=((SensorData *)sensorDatas[0]).gatherTime;
    for(SensorData *sensorData in sensorDatas){
        NSArray *array=[sensorData.temp componentsSeparatedByString:@","];
        [tempArray addObject:array];
    }
    float maxT=-100;
    float minT=1000;
    float avgT=0;
    float sumT=0;
    int count=0;
    //仓内温度汇总
    for(NSArray *array in tempArray){
        for(int i=0;i<array.count;i++){
            float tempT;
            if([array[i] isEqualToString:@"--"])
                continue;
            else{
                tempT=((NSString *)array[i]).floatValue;
                if(maxT<tempT)
                    maxT=tempT;
                if(minT>tempT)
                    minT=tempT;
                sumT+=tempT;
                count++;
            }
        }
    }
    if(count!=0)
        avgT=sumT/count;
    BinSum *binSum=[BinSum binSumWithID:@(0) gatherTime:gatherTime binID:@(binID) layer:@(0) maxT:[CXMGlobal decimalwithFormat:maxT] minT:[CXMGlobal decimalwithFormat:minT] avgT:[CXMGlobal decimalwithFormat:avgT] maxM:@(-100) minM:@(-100) avgM:@(-100)];
    [[BinSumOperation sharedBinSumOperation]addBinSum:binSum];
    //每一层
    
}


//控制命令解析
-(void)controlFrameDecode{
    int state=frameBytes[5];
    int fanNumber=frameBytes[4];
    int station=frameBytes[1];
    int ctr=frameBytes[6];
    int fanState=ctr>>(fanNumber-1)&1;
    NSString *gatherTime=[CXMGlobal getCurrentDateTime];
    Bin *bin=[[BinOperation sharedBinOperation]getBinByStation:@(station)];
    if(bin==nil)
        return;
    if(state==0){
        
        NSArray *fans=[[FanOperation sharedFanOperation]getFansByBinID:bin.ID];
        for(Fans *fan in fans){
            if(fan.fanNumber.intValue==fanNumber){
                FanRecords *record=[FanRecords recordsWithID:@(0) fanID:fan.ID gatherTime:gatherTime operation:[NSString stringWithFormat:@"%d",fanState] runTime:@(0)];
                [[FanRecordOperation sharedFanRecordOperation]addRecord:record];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"control" object:self userInfo:@{@"binID":bin.ID,@"fanNumber":@(fanNumber),@"fanState":@(fanState)}];
    }else if(state==1){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"control" object:self userInfo:@{@"binID":bin.ID,@"fanNumber":@(fanNumber),@"fanState":@"Data Exception"}];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"control" object:self userInfo:@{@"binID":bin.ID,@"fanNumber":@(fanNumber),@"fanState":@"Repeat Operation!"}];
    }
}









@end
