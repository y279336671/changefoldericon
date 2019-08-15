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
#import "RightList.h"
#import "BottomView.h"
#import "TopViewController.h"

@interface MainViewController()<RightListDelegate>
@property (nonatomic, strong)RightList *rightList;
@property (nonatomic, strong)BottomView *bottomView;
@property (nonatomic, strong)TopViewController *topVC;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //开机自动启动
    [Tools setLaunchAgents:false];
    
    [self openAlert];
    
    [self.view addSubview:self.rightList];
    [self.view addSubview:self.bottomView];
    
    self.topVC = [[TopViewController alloc]init];
    self.topVC.view.frame = CGRectMake(0, 200, self.view.frame.size.width - 80, self.view.frame.size.height - 200);
    [self.view addSubview:self.topVC.view];
    
    NSButton *btn = [NSButton buttonWithTitle:@"选择文件" target:self action:@selector(btnClick)];
    btn.layer.backgroundColor = [NSColor yellowColor].CGColor;
    btn.frame = CGRectMake(0, 0, 100, 50);
    [self.view addSubview:btn];
}

- (void)openAlert{
    
    BOOL hasShowAlert = [[NSUserDefaults standardUserDefaults]boolForKey:@"khasShowAlert"];
    if (hasShowAlert) {
        return;
    }
    
    NSAlert *alert = [[NSAlert alloc] init];
    alert.alertStyle = NSAlertStyleWarning;
    [alert addButtonWithTitle:@"确定"];
    alert.messageText = @"为了更方便使用右键修改功能，请先前往设置-扩展勾选ChangeFolderIcon里的扩展";
    alert.informativeText = @"";
    
    [alert beginSheetModalForWindow:[AppDelegate appDelegate].window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSAlertFirstButtonReturn) {
            NSLog(@"确定");
            
            [[NSWorkspace sharedWorkspace] openFile:@"/System/Library/PreferencePanes/Extensions.prefPane"];
            
        }
    }];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"khasShowAlert"];
    [defaults synchronize];
}

- (void)btnClick
{
    DragViewController *dvc = [[DragViewController alloc]init];
    [self presentViewControllerAsSheet:dvc];
}

- (void)rightListClickAt:(NSInteger)index
{
    [self.bottomView updateIcons:index];
    [self.topVC scrolltoIndex:index];
}

- (BottomView *)bottomView
{
    if(_bottomView == nil) {
        _bottomView = [[BottomView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 80, 200)];
        _bottomView.wantsLayer = YES;
    }
    return _bottomView;

}


- (RightList *)rightList
{
    if (_rightList == nil) {
        _rightList = [[RightList alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, 0, 80, self.view.frame.size.height)];
        _rightList.delegate = self;
    }
    return _rightList;
}

@end
