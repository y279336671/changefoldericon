//
//  TopViewController.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/8/13.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "TopViewController.h"

#import "MBCoverFlowView.h"


@interface TopViewController ()

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    
    MBCoverFlowView *flowView = [[MBCoverFlowView alloc]initWithFrame:self.view.bounds];
    self.view = flowView;
    
    NSViewController *labelViewController = [[NSViewController alloc] initWithNibName:nil bundle:nil];
    NSTextField *label = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 10, 10)];
    [label setBordered:NO];
    [label setBezeled:NO];
    [label setEditable:NO];
    [label setSelectable:NO];
    [label setDrawsBackground:NO];
    [label setTextColor:[NSColor whiteColor]];
    [label setFont:[NSFont boldSystemFontOfSize:12.0]];
    [label setAutoresizingMask:NSViewWidthSizable];
    [label setAlignment:NSTextAlignmentCenter];
    [label sizeToFit];
    NSRect labelFrame = [label frame];
    labelFrame.size.width = 400;
    [label setFrame:labelFrame];
    [labelViewController setView:label];
    [label bind:@"value" toObject:labelViewController withKeyPath:@"representedObject.name" options:nil];
    [(MBCoverFlowView *)self.view setAccessoryController:labelViewController];
    
    [(MBCoverFlowView *)self.view setImageKeyPath:@"image"];
    [(MBCoverFlowView *)self.view setShowsScrollbar:YES];
    
    [NSThread detachNewThreadSelector:@selector(loadImages) toTarget:self withObject:nil];
}

- (void)loadImages
{
    NSMutableArray *images = [NSMutableArray array];
    
//    NSString *file;
//    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:@"/Library/Desktop Pictures"];
//
//    int count = 0;
//    while ((file = [dirEnum nextObject]))
//    {
//        NSImage *image = [[NSImage alloc] initWithContentsOfFile:[@"/Library/Desktop Pictures" stringByAppendingPathComponent:file]];
//        if (image != nil) {
//            // Scale down the image -- CoreAnimation doesn't like huge images
//            [image setSize:NSMakeSize([image size].width/2, [image size].height/2)];
//            NSDictionary *imageInfo = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", file, @"name", nil];
//            [images addObject:imageInfo];
//        }
//
//        [(MBCoverFlowView *)self.view performSelectorOnMainThread:@selector(setContent:) withObject:images waitUntilDone:NO];
//
//        count++;
//    }
    
    
    
    int count = 1;
    while (count < 10)
    {
        NSString *name = [NSString stringWithFormat:@"e%d",count];
        NSImage *image = [NSImage imageNamed:name];
        if (image != nil) {
            // Scale down the image -- CoreAnimation doesn't like huge images
            [image setSize:NSMakeSize([image size].width/2, [image size].height/2)];
            NSDictionary *imageInfo = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", name, @"name", nil];
            [images addObject:imageInfo];
        }
        
        [(MBCoverFlowView *)self.view performSelectorOnMainThread:@selector(setContent:) withObject:images waitUntilDone:NO];
        
        count++;
    }
    
    
}
@end
