//
//  DestinationView.h
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/7/22.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol DragDropViewDelegate <NSObject>
-(void)dragDropViewFileList:(NSArray*)fileList;
@end

@interface DestinationView : NSView
@property (weak) id<DragDropViewDelegate> delegate;

@end

