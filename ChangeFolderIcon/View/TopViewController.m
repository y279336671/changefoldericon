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
@property (nonatomic, strong) MBCoverFlowView *flowView;
@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    
    MBCoverFlowView *flowView = [[MBCoverFlowView alloc]initWithFrame:CGRectMake(0, 0, 600, 200)];
    [self.view addSubview:flowView];
    self.flowView = flowView;
    
    [self.flowView setImageKeyPath:@"image"];
    [self.flowView setShowsScrollbar:YES];
    
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
    while (count < 15)
    {
        NSString *name = [NSString stringWithFormat:@"%d",count];
        NSImage *image = [NSImage imageNamed:name];
        if (image != nil) {
            // Scale down the image -- CoreAnimation doesn't like huge images
            [image setSize:NSMakeSize(100, 75)];
            NSDictionary *imageInfo = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", @"", @"name", nil];
            [images addObject:imageInfo];
        }
        
        [self.flowView performSelectorOnMainThread:@selector(setContent:) withObject:images waitUntilDone:NO];
        
        count++;
    }
}

- (void)scrolltoIndex:(NSInteger)index
{
    self.flowView.selectionIndex = index;
}

- (void)mouseDown:(NSEvent *)theEvent
{
    
}
@end
