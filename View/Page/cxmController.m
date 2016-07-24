//
//  cxmController.m
//  JC8030
//
//  Created by cxm on 16/7/9.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "cxmController.h"
#import "Client.h"

@interface cxmController ()

@end

@implementation cxmController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)connect:(id)sender{
    [[Client sharedClient]connectToHost];
}

-(IBAction)sendData:(id)sender{
    //[[Client sharedClient]sendData:sendText.text];
}
@end
