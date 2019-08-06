//
//  AppDelegate.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/7/22.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "AppDelegate.h"
#import "iTermServiceProvider.h"

@interface AppDelegate () <NSApplicationDelegate>

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self addStatusItem];

    /* 以下为右键服务的功能
//    [NSApp registerServicesMenuSendTypes:[NSArray arrayWithObjects:NSPasteboardTypeString, nil]
//                             returnTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, NSStringPboardType, nil]];

//    dispatch_async(dispatch_get_main_queue(), ^{
//        [NSApp setServicesProvider:[[iTermServiceProvider alloc] init]];
//    });
    */
}

//- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender
//                    hasVisibleWindows:(BOOL)flag{
//    
//    self.homeViewController = [[DDHomeViewController alloc]
//                               initWithWindowNibName:@"DDHomeViewController"];
//    
//    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
//    
//    [self.homeViewController showWindow:nil];
//    
//    return YES;
//    
//}

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


}

- (void)handleButtonClick:(id)sender
{

}


@end
