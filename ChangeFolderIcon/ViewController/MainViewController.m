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
#import "AppDelegate.h"

@interface MainViewController()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //开机自动启动
    [Tools setLaunchAgents:false];
    
    [self openAlert];
    
    NSButton *btn = [NSButton buttonWithTitle:@"选择文件" target:self action:@selector(btnClick)];
    btn.layer.backgroundColor = [NSColor yellowColor].CGColor;
    btn.frame = CGRectMake(0, 0, 100, 50);
    [self.view addSubview:btn];
}

- (void)openAlert{
    
    NSAlert *alert = [[NSAlert alloc] init];
    alert.alertStyle = NSAlertStyleWarning;
    [alert addButtonWithTitle:@"确定"];
    [alert addButtonWithTitle:@"取消"];
    alert.messageText = @"为了更方便使用右键修改功能，请先前往设置-扩展勾选ChangeFolderIcon里的扩展";
    alert.informativeText = @"";
    
    [alert beginSheetModalForWindow:[AppDelegate appDelegate].window completionHandler:^(NSModalResponse returnCode) {
        //        NSLog(@"%d", returnCode);
        if (returnCode == NSAlertFirstButtonReturn) {
            NSLog(@"确定");
            
            [[NSWorkspace sharedWorkspace] openFile:@"/System/Library/PreferencePanes/Extensions.prefPane"];
            
        } else if (returnCode == NSAlertSecondButtonReturn) {
            NSLog(@"取消");
        } else {
            NSLog(@"其他按钮");
        }
    }];
}

- (void)btnClick
{
    DragViewController *dvc = [[DragViewController alloc]init];
    [self presentViewControllerAsSheet:dvc];
}


@end
