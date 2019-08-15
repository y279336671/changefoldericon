//
//  AppDelegate.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/7/22.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "AppDelegate.h"
#import "Tools.h"
#import "MyWindow.h"
#import "MainViewController.h"

@interface AppDelegate () <NSApplicationDelegate, NSMenuDelegate>
@property(nonatomic, strong) NSStatusItem *statusItem;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    self.window = [[MyWindow alloc] initWithContentRect:NSMakeRect(50, 100, 200, 300) styleMask:NSWindowStyleMaskBorderless | NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable backing:NSBackingStoreBuffered defer:YES];
    self.window.contentViewController = [[MainViewController alloc] init];
    [self.window setTitle:@"ChangeFolderIcon"];

    [self addStatusItem];
    //所有活跃应用
//    NSArray* arrayAppList = [[NSWorkspace sharedWorkspace] runningApplications];

    // 处理Mac不同的进程之间的通知
    NSDistributedNotificationCenter *center =
    [NSDistributedNotificationCenter defaultCenter];
    [center addObserver: self
               selector: @selector(callbackWithNotification:)
                   name: @"PiaoYun Notification"
                 object: nil];
    [center addObserver: self
               selector: @selector(callbackWithNotification:)
                   name: @"PiaoYun Notification1"
                 object: nil];
    
    [self openApp];
}

//回调：
- (void)callbackWithNotification:(NSNotification *)myNotification;
{
    NSLog(@"Notification Received");
    NSString *str = (NSString *)myNotification.object;
    NSArray *array = [str componentsSeparatedByString:@";"];
    NSString *path = array[0];
    NSString *imageName = array[1];
    [self changeIcon:path withImageName:imageName];
}

- (void)changeIcon:(NSString *)path withImageName:(NSString *)iamgeaName
{
    NSWorkspace *workSpace = [NSWorkspace sharedWorkspace];
    [workSpace setIcon:nil forFile:path options:NSExcludeQuickDrawElementsIconCreationOption];
    NSImage *image = [NSImage imageNamed:iamgeaName];
    BOOL success = [workSpace setIcon:image forFile:path options:NSExcludeQuickDrawElementsIconCreationOption];
    if (success) {
       
        NSLog(@"修改成功");
    }
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

    [self bindSubMenu];
}

- (void)handleButtonClick:(NSStatusBarButton *)sender {
    NSLog(@"handleButtonClick");
    NSString *bundleId = [[Tools getAppInfo] objectForKey:@"CFBundleIdentifier"];
    NSArray *array = [NSRunningApplication runningApplicationsWithBundleIdentifier:bundleId];
    if ([array count] > 0) {
        NSRunningApplication *runningApp = [array objectAtIndex:0];
        if (!runningApp.isActive) {
            [self openApp];
        }
        [self bindSubMenu];
    }
}

- (void)bindSubMenu {
    NSLog(@"bindSubMenu");
    NSString *appName = [[Tools getAppInfo] objectForKey:@"CFBundleName"];
    NSMenu *subMenu = [[NSMenu alloc] initWithTitle:@""];
    [subMenu addItemWithTitle:[NSString stringWithFormat:@"打开%@", appName] action:@selector(openApp) keyEquivalent:@""];
    [subMenu addItemWithTitle:[NSString stringWithFormat:@"退出%@", appName] action:@selector(exitApp) keyEquivalent:@""];
    self.statusItem.menu = subMenu;
    self.statusItem.menu.delegate = self;
}

- (void)unBindSubMenu {
    NSLog(@"unBindSubMenu");
    self.statusItem.menu.delegate = nil;
    self.statusItem.menu = nil;
}

- (void)menuWillOpen:(NSMenu *)menu {
    NSLog(@"menuWillOpen");
}

- (void)menuDidClose:(NSMenu *)menu {
//    NSLog(@"menuDidClose");
//    NSString *bundleId = [[Tools getAppInfo] objectForKey:@"CFBundleIdentifier"];
//    NSArray *array = [NSRunningApplication runningApplicationsWithBundleIdentifier:bundleId];
//    if ([array count] > 0) {
//        NSRunningApplication *runningApp = [array objectAtIndex:0];
//        if (runningApp.isActive) {
//            [self bindSubMenu];
//
//        } else{
//            [self unBindSubMenu];
//        }
//
//    }

}

//显示主界面
- (void)openApp {

    [self.window makeKeyAndOrderFront:nil];
    [self bringToFront];
}

//退出应用
- (void)exitApp {
    [[NSApplication sharedApplication] terminate:self];
}

//应用显示在最前面
- (void)bringToFront {
    NSString *bundleId = [[Tools getAppInfo] objectForKey:@"CFBundleIdentifier"];
    NSArray *array = [NSRunningApplication runningApplicationsWithBundleIdentifier:bundleId];
    if ([array count] > 0) {
        NSRunningApplication *runningApp = [array objectAtIndex:0];
        [runningApp activateWithOptions:NSApplicationActivateIgnoringOtherApps];
    }
}

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[NSApplication sharedApplication].delegate;
}
@end
