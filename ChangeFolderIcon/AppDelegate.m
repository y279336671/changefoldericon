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
@property (nonatomic, strong)NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    self.window = [[MyWindow alloc] initWithContentRect:NSMakeRect(50, 100, 200, 300) styleMask:NSWindowStyleMaskBorderless | NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable backing:NSBackingStoreBuffered defer:YES];
    self.window.contentViewController = [[MainViewController alloc] init];
    [self.window setTitle:@"test1"];

    [self addStatusItem];
    //所有活跃应用
//    NSArray* arrayAppList = [[NSWorkspace sharedWorkspace] runningApplications];

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

    button.action = @selector(handleButtonClick:);


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
    NSLog(@"menuDidClose");
    NSString *bundleId = [[Tools getAppInfo] objectForKey:@"CFBundleIdentifier"];
    NSArray *array = [NSRunningApplication runningApplicationsWithBundleIdentifier:bundleId];
    if ([array count] > 0) {
        NSRunningApplication *runningApp = [array objectAtIndex:0];
        if (runningApp.isActive) {
            [self bindSubMenu];

        } else{
            [self unBindSubMenu];
        }

    }

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
@end
