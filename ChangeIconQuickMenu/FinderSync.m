//
//  FinderSync.m
//  DemoFinderSync
//
//  Created by Yang on 12/2/15.
//  Copyright © 2015 Yang. All rights reserved.
//

#import "FinderSync.h"

typedef void (^URLActionBlock)(NSURL * obj, NSUInteger idx, BOOL *stop);

@interface FinderSync ()

@property NSURL *myFolderURL;

@end

@implementation FinderSync


- (instancetype)init {
    self = [super init];
    self.myFolderURL = [NSURL fileURLWithPath:@"/"];
    [FIFinderSyncController defaultController].directoryURLs = [NSSet setWithObject:self.myFolderURL];
    
    return self;
}

#pragma mark - Primary Finder Sync protocol methods
- (void)beginObservingDirectoryAtURL:(NSURL *)url {
    
}


- (void)endObservingDirectoryAtURL:(NSURL *)url {
    
}

- (void)requestBadgeIdentifierForURL:(NSURL *)url {
    
}

#pragma mark - Menu and toolbar item support
- (NSString *)toolbarItemName {
    return @"AnyShare";
}

- (NSString *)toolbarItemToolTip {
    return @"AnyShare: 使用AnyShare相关的功能";
}

- (NSImage *)toolbarItemImage {
    NSImage * toolBarIcon = [NSImage imageNamed:@"Menu"];
    toolBarIcon.template = YES;
    return toolBarIcon;
}

- (NSMenu *)menuForMenuKind:(FIMenuKind)whichMenu {
    NSMenu *menu = nil;
    
    switch (whichMenu) {
            
            case FIMenuKindContextualMenuForItems:
            menu = [self fileMenu];
            break;
        default:
            break;
    }
    
    return menu;
}

- (IBAction)gotoMyFolder:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:self.myFolderURL];
}

- (void)actionToSelectedURLs:(URLActionBlock)action
{
    NSArray* items = [FIFinderSyncController defaultController].selectedItemURLs;
    if (items.count) {
        [items enumerateObjectsUsingBlock:^(NSURL * obj, NSUInteger idx, BOOL * stop) {
            if (![self fileUrlIsInvisible:obj]) {
                action(obj, idx, stop);
            }
        }];
    }
    else {
        action([FIFinderSyncController defaultController].targetedURL, 0, nil);
    }
    
}

- (NSMenu *)fileMenu
{
    if (![self validateFileMenu]) {
        return nil;
    }
    
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"111"];
    NSMenuItem * menuItem = [[NSMenuItem alloc] initWithTitle:@"修改文件夹图标" action:@selector(testChangeIcon:) keyEquivalent:@""];
    menuItem.image = [NSImage imageNamed:@"menu"];
    
    
    NSMenu *subMenu = [[NSMenu alloc] initWithTitle:@""];
    
    NSMenuItem * makeColorItem = [[NSMenuItem alloc] initWithTitle:@"icon1" action:@selector(testChangeIcon:) keyEquivalent:@""];
    makeColorItem.image = [NSImage imageNamed:@"icon1"];
    
    NSMenuItem * makeUserItem = [[NSMenuItem alloc] initWithTitle:@"icon2" action:@selector(testChangeIcon:) keyEquivalent:@""];
    makeUserItem.image = [NSImage imageNamed:@"icon2"];
    
    NSMenuItem * testItem = [[NSMenuItem alloc] initWithTitle:@"music" action:@selector(testChangeIcon:) keyEquivalent:@""];
    testItem.image = [NSImage imageNamed:@"music"];
    
    [subMenu addItem:makeColorItem];
    [subMenu addItem:makeUserItem];
    [subMenu addItem:testItem];
    
//    menuItem.submenu = subMenu;
    //    NSLog(@"finderSyncController==%@",finderSyncController.menu);
    [menu addItem:menuItem];
    
    return menu;
}


- (void)changeIcon:(NSURL *)pathUrl withImage:(NSString *)imageName
{
    NSString *path = [pathUrl path];
    
    NSString *str = [NSString stringWithFormat:@"%@;%@",path,imageName];
    
    //    NSString *observedObject = @"com.changeIcon.shareData";
    NSDistributedNotificationCenter *center1 =
    [NSDistributedNotificationCenter defaultCenter];
    [center1 postNotificationName: @"PiaoYun Notification1"
                           object: str
                         userInfo: nil /* no dictionary */
               deliverImmediately: YES];
}

- (void)testChangeIcon:(NSMenuItem *)item
{
    NSLog(@"testChangeIcon click");
    __weak typeof(self) weakSelf = self;
    [self actionToSelectedURLs:^(NSURL * obj, NSUInteger idx, BOOL *stop) {
        [weakSelf changeIcon:obj withImage:item.title];
    }];
}

#pragma validate menu
- (BOOL)validateToolbarMenu
{
    BOOL bResult = NO;
    NSUInteger itemCounts = [FIFinderSyncController defaultController].selectedItemURLs.count;
    bResult = itemCounts == 1 ? YES : NO;
    
    return bResult;
}
- (BOOL)validateFileMenu
{
    BOOL bResult = NO;
    NSUInteger itemCounts = [FIFinderSyncController defaultController].selectedItemURLs.count;
    bResult = itemCounts == 1 ? YES : NO;
    
    return bResult;
}
- (BOOL)validateDirectoryMenu
{
    return YES;
}

- (BOOL)toolBarMenuRequestFromMyFolder
{
    BOOL bResult = NO;
    NSURL * target = [FIFinderSyncController defaultController].targetedURL;
    bResult = [self path:target.path isSubPathOfPath:self.myFolderURL.path];
    
    return bResult;
}

#pragma mark path utils
- (BOOL)path:(NSString *)aPath isSubPathOfPath:(NSString *)anotherPath
{
    BOOL bResult = NO;
    
    bResult = [aPath hasPrefix:anotherPath];
    
    return bResult;
}

- (BOOL)fileUrlIsInvisible:(NSURL *)fileUrl
{
    BOOL bResult = NO;
    NSNumber * numIsHidden = nil;
    
    [fileUrl getResourceValue:&numIsHidden forKey:NSURLIsHiddenKey error:NULL];
    bResult = numIsHidden.boolValue;
    
    return bResult;
}

@end



