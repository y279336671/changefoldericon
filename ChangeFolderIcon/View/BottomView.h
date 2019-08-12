//
//  BottomView.h
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/8/12.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface BottomView : NSView
@property (nonatomic, strong)NSScrollView *containerView;
- (void)updateIcons:(NSInteger)type;
@end

NS_ASSUME_NONNULL_END
