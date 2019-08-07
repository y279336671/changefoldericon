//
//  ViewController.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/7/22.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "MainViewController.h"
#import "Tools.h"
#import "DragViewController.h"

@interface MainViewController()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //开机自动启动
    [Tools setLaunchAgents:false];

    self.view.layer.backgroundColor =  [NSColor redColor].CGColor;

    
    NSButton *btn = [NSButton buttonWithTitle:@"选择文件" target:self action:@selector(btnClick)];
    btn.layer.backgroundColor = [NSColor yellowColor].CGColor;
    btn.frame = CGRectMake(0, 0, 100, 50);
    [self.view addSubview:btn];
}

- (void)btnClick
{
    DragViewController *dvc = [[DragViewController alloc]init];
    [self presentViewControllerAsSheet:dvc];
}


@end
