//
//  BaseConroller.m
//  JC8030
//
//  Created by cxm on 16/6/17.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"


@interface BaseConroller (){
    UIImageView *navBarHairlineImageView;
}
@end

@implementation BaseConroller

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    navBarHairlineImageView.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.extendedLayoutIncludesOpaqueBars=NO;
    self.edgesForExtendedLayout=UIRectEdgeBottom|UIRectEdgeLeft|UIRectEdgeRight;
    
    //隐藏黑线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)setNavigationTitleImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    self.navigationItem.titleView = imageView;
}


- (UIButton *)customButton:(NSString *)imageName title:(NSString*)title
                  selector:(SEL)sel
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    if(![imageName isEqual:@""])
    {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    }else{
        [btn setTitle:title forState:UIControlStateNormal];
    }
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)setNavigationLeft:(NSString *)imageName title:(NSString*)title sel:(SEL)sel
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[self customButton:imageName title:title selector:sel]];
    
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setNavigationRight:(NSString *)imageName title:(NSString*)title tab:(NSString *)tab
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[self customButton:imageName title:title selector:@selector(doRight:)]];
    if([tab isEqualToString:@"tab"])
        self.tabBarController.navigationItem.rightBarButtonItem = item;
    else
        self.navigationItem.rightBarButtonItem = item;
}
-(void)setNavigationLeftOnlyBack:(NSString*)title{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem=item;
}
- (void)setStatusBarStyle:(UIStatusBarStyle)style
{
    
}

- (IBAction)doRight:(id)sender
{
    
}

- (IBAction)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
