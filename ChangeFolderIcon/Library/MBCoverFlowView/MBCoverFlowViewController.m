/*
 
 The MIT License
 
 Copyright (c) 2009 Matthew Ball
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import "MBCoverFlowViewController.h"

#import "MBCoverFlowView.h"

@implementation MBCoverFlowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

//- (void)awakeFromNib
//{    
//    
//}

- (void)loadImages
{
	NSMutableArray *images = [NSMutableArray array];
	
	NSString *file;
	NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:@"/Library/Desktop Pictures"];
	
	int count = 0;
	while ((file = [dirEnum nextObject])) 
	{
		NSImage *image = [[NSImage alloc] initWithContentsOfFile:[@"/Library/Desktop Pictures" stringByAppendingPathComponent:file]];
		if (image != nil) {
			// Scale down the image -- CoreAnimation doesn't like huge images
			[image setSize:NSMakeSize([image size].width/2, [image size].height/2)];
			NSDictionary *imageInfo = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", file, @"name", nil];
			[images addObject:imageInfo];
		}
		
		[(MBCoverFlowView *)self.view performSelectorOnMainThread:@selector(setContent:) withObject:images waitUntilDone:NO];
		
		count++;
	}
	
}

@end
