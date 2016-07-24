//
//  Temperature Unit Table.m
//  JC8030
//
//  Created by cxm on 16/6/30.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "Unit Table.h"
#import "PlistOperation.h"

@implementation Unit_Table

+(Unit_Table*)initWithUnits:(NSString *)units{
    Unit_Table *table=[[Unit_Table alloc]init];
    table->unitsOfSettings=units;
    return table;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%d",settingsItems.count);
    return settingsData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=keys[indexPath.row];
    if([values[indexPath.row] isEqual:@(1)]){
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        selectedIndex=indexPath;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *cells=[tableView visibleCells];
    for(UITableViewCell *cell in cells){
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryCheckmark;
    selectedIndex=indexPath;
}

-(void)readSettings{
    settingsData=[PlistOperation readPlistToDictionary:AppSettingFile withPoint:unitsOfSettings];
    keys=[settingsData allKeys];
    values=[settingsData allValues];
    selectedIndex=[[NSIndexPath alloc]init];
}

-(void)saveSettings{
    for(int i=0;i<settingsData.count;i++){
        if(i==selectedIndex.row)
            [settingsData setValue:@(1) forKey:keys[selectedIndex.row]];
        else
            [settingsData setValue:@(0) forKey:keys[i]];
    }
    
    [PlistOperation updatePlistByDictionary:AppSettingFile withPoint:unitsOfSettings andContent:settingsData];
}
@end
