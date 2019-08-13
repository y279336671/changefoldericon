//
//  BottomView.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/8/12.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

static const CGFloat IconWidth = 50 ;
static const CGFloat BtnInterval = 20 ;
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
    [self addSubview:self.leftBtn];
    [self addSubview:self.rigthBtn];
}

- (void)updateIcons:(NSInteger)type
{
//    for (NSView *subview in self.containerView.subviews) {
//        [subview removeFromSuperview];
//    }

    switch (type) {
        case 0:
            {
                for (NSInteger i = 0; i < 50; i ++) {
                    NSButton *btn = [NSButton buttonWithTitle:@"" target:self action:@selector(btnClick)];
                    btn.frame = CGRectMake(70*i + BtnInterval, 0, IconWidth, 50);
                    btn.wantsLayer = YES;
                    btn.layer.backgroundColor = [NSColor redColor].CGColor;
                    [self.containerView.documentView addSubview:btn];
                }
            }
            break;
        case 1:
            {
                for (NSInteger i = 0; i < 5; i ++) {
                    NSButton *btn = [NSButton buttonWithTitle:@"" target:self action:@selector(btnClick)];
                    btn.frame = CGRectMake(70*i + BtnInterval, 0, IconWidth, 50);
                    btn.wantsLayer = YES;
                    btn.layer.backgroundColor = [NSColor greenColor].CGColor;
                    [self.containerView.documentView addSubview:btn];
                }
            }
            break;
        case 2:
            {
                for (NSInteger i = 0; i < 5; i ++) {
                    NSButton *btn = [NSButton buttonWithTitle:@"" target:self action:@selector(btnClick)];
                    btn.frame = CGRectMake(70*i + BtnInterval, 0, IconWidth, 50);
                    btn.wantsLayer = YES;
                    btn.layer.backgroundColor = [NSColor blueColor].CGColor;
                    [self.containerView.documentView addSubview:btn];
                }
            }
            break;
        case 3:
            {
                for (NSInteger i = 0; i < 5; i ++) {
                    NSButton *btn = [NSButton buttonWithTitle:@"" target:self action:@selector(btnClick)];
                    btn.frame = CGRectMake(70*i + BtnInterval, 0, IconWidth, 50);
                    btn.wantsLayer = YES;
                    btn.layer.backgroundColor = [NSColor blackColor].CGColor;
                    [self.containerView.documentView addSubview:btn];
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
        _containerView = [[NSScrollView alloc]initWithFrame:CGRectMake(20, 80, self.frame.size.width-40, 80)];
        _containerView.documentView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 1000, 50)];//todo 这个宽度需要根据具体的按钮个数来设定
        _containerView.hasHorizontalScroller = true;
    }
    return _containerView;
}

- (void)btnClick
{
    
}

-(NSButton*)leftBtn{
    if(_leftBtn==nil){
        _leftBtn = [NSButton buttonWithTitle:@"⬅️" target:self action:@selector(leftClick)];
        _leftBtn.layer.backgroundColor = [NSColor yellowColor].CGColor;
        _leftBtn.frame = CGRectMake(0, 80, 50, 20);
    }
    return _leftBtn;
}



-(NSButton*)rigthBtn{
    if(_rigthBtn==nil){
        _rigthBtn = [NSButton buttonWithTitle:@"➡️" target:self action:@selector(rightClick)];
        _rigthBtn.layer.backgroundColor = [NSColor yellowColor].CGColor;
        _rigthBtn.frame = CGRectMake(self.containerView.x+self.containerView.width, 80, 50, 20);
    }
    return _rigthBtn;
}

-(void)leftClick{
    //todo 移动位置不对
    [self.containerView.documentView scrollPoint:NSMakePoint(self.containerView.documentView.x-IconWidth-BtnInterval, self.containerView.documentView.y)];
}

-(void)rightClick{
    //todo 移动位置不对
    [self.containerView.documentView scrollPoint:NSMakePoint(self.containerView.documentView.x+IconWidth+BtnInterval, self.containerView.documentView.y)];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
