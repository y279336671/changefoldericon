//
//  RightListCell.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/8/12.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "RightListCell.h"

@implementation RightListCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
     
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [[NSColor redColor] setFill];
    NSRectFill(dirtyRect);
}
@end
