//
//  iTermServiceProvider.m
//  iTerm2
//
//  Created by liupeng on 08/12/2016.
//
//

#import <AppKit/AppKit.h>
#import "iTermServiceProvider.h"

@implementation iTermServiceProvider


- (void)changeFolderIcon:(NSPasteboard*)pasteboard userData:(NSString *)userData error:(NSError **)error {
    NSArray *filePathArray = [pasteboard propertyListForType:NSFilenamesPboardType];
    for (NSString *path in filePathArray) {
        BOOL isDirectory = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
            if (!isDirectory) {
                NSLog(@"%@",path);
//                windowController = [self openTab:allowTabs inTerminal:windowController directory:[path stringByDeletingLastPathComponent]];
            } else {
//                windowController = [self openTab:allowTabs inTerminal:windowController directory:path];
            }
        }
    }
}





@end
