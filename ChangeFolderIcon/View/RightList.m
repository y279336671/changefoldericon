//
//  RightList.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/8/12.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "RightList.h"
#import "RightListCell.h"

@interface RightList()<NSTableViewDelegate,NSTableViewDataSource>
@property (nonatomic, strong)NSView *contentView;
@end

@implementation RightList

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self addSubview:self.myScrollView];
    self.myScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.myScrollView.documentView = self.contentView;
    [self createCell];
}

- (void)createCell
{
    NSInteger count = 0;
    for (NSInteger i = 0; i < 20; i ++) {
        RightListCell *cell = [RightListCell buttonWithTitle:@"" target:self action:@selector(buttonClick:)];
        cell.tag = i;
        cell.frame = CGRectMake(30, 40 * i + 10, 20, 20);
        
        [self.contentView addSubview:cell];

        count = i;
    }
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, count * 40);

}

- (void)buttonClick:(RightListCell *)btn
{
    NSInteger index = btn.tag;
    if([self.delegate respondsToSelector:@selector(rightListClickAt:)]){
        [self.delegate rightListClickAt:index];
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    
    [super drawRect:dirtyRect];
}

- (NSView *)contentView
{
    if(_contentView == nil) {
        _contentView = [[NSView alloc]initWithFrame:self.myScrollView.frame];
        _contentView.wantsLayer = YES;
    }
    return _contentView;
}

- (NSScrollView *)myScrollView
{
    if (_myScrollView == nil) {
        _myScrollView = [[NSScrollView alloc]init];
        _myScrollView.scrollerStyle = NSScrollerStyleOverlay;
        [_myScrollView setHasVerticalScroller:YES];
    }
    return _myScrollView;
}

@end
