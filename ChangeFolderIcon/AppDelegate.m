//
//  AppDelegate.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/7/22.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "AppDelegate.h"
#import "iTermServiceProvider.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [NSApp registerServicesMenuSendTypes:[NSArray arrayWithObjects:NSPasteboardTypeString, nil]
                             returnTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, NSStringPboardType, nil]];
    // Insert code here to initialize your application
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSApp setServicesProvider:[[iTermServiceProvider alloc] init]];
    });
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
