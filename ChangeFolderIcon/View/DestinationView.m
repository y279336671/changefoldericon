//
//  DestinationView.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/7/22.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "DestinationView.h"

@interface DestinationView() <NSDraggingDestination>

@end

@implementation DestinationView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [self setup];
}

- (void)setup
{
    [self registerForDraggedTypes:@[NSPasteboardTypeURL]];
}

//https://juejin.im/post/5b39ca1b51882574eb599a1c
//- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
//{
//
//}
//
//- (BOOL)shouldAllowDrag:(id<NSDraggingInfo>)dragginInfo
//{
//    BOOL canAccept = NO;
//    NSPasteboard * pasteBoard = dragginInfo.draggingPasteboard;
//    NSDictionary * filteringOptions = @[NSPasteboardURLReadingContentsConformToTypesKey:NSImage.imagetype];
//    if ([pasteBoard canReadObjectForClasses:@[NSURL] options: filteringOptions]) {
//
//    }
//}


@end
