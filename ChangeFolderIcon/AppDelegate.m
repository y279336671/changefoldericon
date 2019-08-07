//
//  AppDelegate.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/7/22.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "AppDelegate.h"
#import "PopoverViewController.h"
#import "MyWindow.h"
#import "MainViewController.h"
@interface AppDelegate () <NSApplicationDelegate>
@property (nonatomic,strong) NSStatusItem *statusItem;
//@property(nonatomic,strong) NSPopover *firstPopover;
//@property(nonatomic,strong) PopoverViewController *popoverVC;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self addStatusItem];
   
    [self openApp];

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
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

    NSMenu *subMenu = [[NSMenu alloc] initWithTitle:@""];

    [subMenu addItemWithTitle:@"打开Fier"action:@selector(openApp) keyEquivalent:@""];
    [subMenu addItemWithTitle:@"退出Fier"action:@selector(exitApp) keyEquivalent:@""];

    self.statusItem.menu = subMenu;
    //todo  第一次点击显示程序主界面 第二次显示菜单
}

//点击statusitem
- (void)handleButtonClick:(NSButton *)btn
{
 //    [self.firstPopover showRelativeToRect:[btn bounds] ofView:btn preferredEdge:NSRectEdgeMaxY];
}

//显示主界面
-(void)openApp{
    NSWindow *window = [[MyWindow alloc] initWithContentRect:NSMakeRect(50, 100, 200, 300)styleMask:NSWindowStyleMaskBorderless|NSWindowStyleMaskTitled|NSWindowStyleMaskClosable|NSWindowStyleMaskMiniaturizable backing:NSBackingStoreBuffered defer:YES];
    
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
    NSString *bundleId = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleIdentifier"];
    NSArray *array = [NSRunningApplication runningApplicationsWithBundleIdentifier:bundleId];
    if ([array count] > 0)
    {
        NSRunningApplication *runningApp = [array objectAtIndex:0];
        [runningApp activateWithOptions:NSApplicationActivateIgnoringOtherApps];
    }
}
@end
