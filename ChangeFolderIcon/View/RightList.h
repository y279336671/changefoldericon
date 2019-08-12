//
//  RightList.h
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/8/12.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RightListDelegate <NSObject>

- (void)rightListClickAt:(NSInteger)index;

@end

@interface RightList : NSView
@property (nonatomic,strong)NSScrollView *myScrollView;
@property (weak)id <RightListDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
