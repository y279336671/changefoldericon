//
//  BottomView.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/8/12.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self addSubview:self.containerView];
}

- (void)updateIcons:(NSInteger)type
{
//    for (NSView *subview in self.containerView.subviews) {
//        [subview removeFromSuperview];
//    }
    //todo  滚不了
    switch (type) {
        case 0:
            {
                for (NSInteger i = 0; i < 50; i ++) {
                    NSButton *btn = [NSButton buttonWithTitle:@"" target:self action:@selector(btnClick)];
                    btn.frame = CGRectMake(70*i + 20, 0, 50, 50);
                    btn.wantsLayer = YES;
                    btn.layer.backgroundColor = [NSColor redColor].CGColor;
                    [self.containerView.contentView addSubview:btn];

                }
            }
            break;
        case 1:
            {
                for (NSInteger i = 0; i < 5; i ++) {
                    NSButton *btn = [NSButton buttonWithTitle:@"" target:self action:@selector(btnClick)];
                    btn.frame = CGRectMake(70*i + 20, 0, 50, 50);
                    btn.wantsLayer = YES;
                    btn.layer.backgroundColor = [NSColor greenColor].CGColor;
                    [self.containerView.contentView addSubview:btn];
                }
            }
            break;
        case 2:
            {
                for (NSInteger i = 0; i < 5; i ++) {
                    NSButton *btn = [NSButton buttonWithTitle:@"" target:self action:@selector(btnClick)];
                    btn.frame = CGRectMake(70*i + 20, 0, 50, 50);
                    btn.wantsLayer = YES;
                    btn.layer.backgroundColor = [NSColor blueColor].CGColor;
                    [self.containerView.contentView addSubview:btn];
                }
            }
            break;
        case 3:
            {
                for (NSInteger i = 0; i < 5; i ++) {
                    NSButton *btn = [NSButton buttonWithTitle:@"" target:self action:@selector(btnClick)];
                    btn.frame = CGRectMake(70*i + 20, 0, 50, 50);
                    btn.wantsLayer = YES;
                    btn.layer.backgroundColor = [NSColor blackColor].CGColor;
                    [self.containerView.contentView addSubview:btn];
                }
            }
            break;
        default:
            break;
    }
}

- (NSScrollView *)containerView
{
    if (_containerView == nil) {

        _containerView = [[NSScrollView alloc]initWithFrame:CGRectMake(0, 80, self.frame.size.width, 50)];
        [_containerView setContentView:[[NSClipView alloc] initWithFrame:NSMakeRect(0, 0, 1000, 50)]];
    }
    return _containerView;
}

- (void)btnClick
{
    
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
