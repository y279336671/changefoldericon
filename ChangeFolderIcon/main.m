//
//  main.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/7/22.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

void notificationCallback (CFNotificationCenterRef center,
                           void * observer,
                           CFStringRef name,
                           const void * object,
                           CFDictionaryRef userInfo) {
    CFShow(CFSTR("Received notification (dictionary):"));
    // print out user info
    const void * keys;
    const void * values;
    CFDictionaryGetKeysAndValues(userInfo, &keys, &values);
    for (int i = 0; i < CFDictionaryGetCount(userInfo); i++) {
        const char * keyStr = CFStringGetCStringPtr((CFStringRef)&keys[i], CFStringGetSystemEncoding());
        const char * valStr = CFStringGetCStringPtr((CFStringRef)&values[i], CFStringGetSystemEncoding());
        printf("\t\t \"%s\" = \"%s\"\n", keyStr, valStr);
    }
}

int main(int argc, const char * argv[]) {
    
    CFNotificationCenterRef center = CFNotificationCenterGetDarwinNotifyCenter();
    // add an observer
    CFNotificationCenterAddObserver(center, NULL, notificationCallback,
                                    CFSTR("MyNotification"), NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);

    

    
    NSApplication *app = [NSApplication sharedApplication];

    id delegate = [[AppDelegate alloc] init];

    app.delegate = delegate;
    
    // remove oberver
//    CFNotificationCenterRemoveObserver(center, NULL, CFSTR("TestValue"), NULL);
    
    
    return NSApplicationMain(argc, argv);
}
