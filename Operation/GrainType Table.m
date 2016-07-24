//
//  GrainType Table.m
//  JC8030
//
//  Created by cxm on 16/6/30.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "GrainType Table.h"

@implementation GrainType_Table

+(GrainType_Table *)init{
    GrainType_Table * grainTypeTable=[[GrainType_Table alloc]init];
    NSString *configFile = [[NSBundle mainBundle] pathForResource:@"grainType" ofType:@"plist"];
    grainTypeTable->grainTypes = [NSArray arrayWithContentsOfFile:configFile];
    return grainTypeTable;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%d",settingsItems.count);
    return grainTypes.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=grainTypes[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *cells=[tableView visibleCells];
    for(UITableViewCell *cell in cells){
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryCheckmark;
    self.selectedGrainType=grainTypes[indexPath.row];
}

@end
