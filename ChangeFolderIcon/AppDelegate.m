//
//  AppDelegate.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/7/22.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "AppDelegate.h"
#import "iTermServiceProvider.h"
#import "Tools.h"
#import "MyWindow.h"
#import "MainViewController.h"
@interface AppDelegate () <NSApplicationDelegate>
@property (nonatomic,strong) NSStatusItem *statusItem;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self addStatusItem];

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
   
}

- (void)addStatusItem {

    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];

    self.statusItem = [statusBar statusItemWithLength:NSSquareStatusItemLength];

    NSImage *image = [NSImage imageNamed:@"music"];

    image.template = YES;

    self.statusItem.button.image = image;

    NSStatusBarButton *button = self.statusItem.button;

    button.target = self;

//    button.action = @selector(handleButtonClick:);

    NSString *appName = [[Tools getAppInfo]objectForKey:@"CFBundleName"];
    
    NSMenu *subMenu = [[NSMenu alloc] initWithTitle:@""];
    [subMenu addItemWithTitle:[NSString stringWithFormat:@"打开%@",appName] action:@selector(openApp) keyEquivalent:@""];
    [subMenu addItemWithTitle:[NSString stringWithFormat:@"退出%@",appName] action:@selector(exitApp) keyEquivalent:@""];

    self.statusItem.menu = subMenu;
    //todo  第一次点击显示程序主界面 第二次显示菜单
}

//显示主界面
-(void)openApp{
    NSWindow *window = [[MyWindow alloc] initWithContentRect:NSMakeRect(50, 100, 200, 300)styleMask:NSWindowStyleMaskBorderless|NSWindowStyleMaskTitled|NSWindowStyleMaskClosable|NSWindowStyleMaskMiniaturizable|NSWindowStyleMaskResizable backing:NSBackingStoreBuffered defer:YES];
    
    window.contentViewController = [[MainViewController alloc]init];
    [window setTitle:@"test1"];
    [window makeKeyAndOrderFront:nil];
    
    [self bringToFront];
}

//退出应用
-(void)exitApp{
    [[NSApplication sharedApplication] terminate:self];
}

//应用显示在最前面
-(void)bringToFront{
    NSString *bundleId =[[Tools getAppInfo]objectForKey:@"CFBundleIdentifier"];
    NSArray *array = [NSRunningApplication runningApplicationsWithBundleIdentifier:bundleId];
    if ([array count] > 0)
    {
        NSRunningApplication *runningApp = [array objectAtIndex:0];
        [runningApp activateWithOptions:NSApplicationActivateIgnoringOtherApps];
    }
}
@end
