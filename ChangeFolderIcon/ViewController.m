//
//  ViewController.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/7/22.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    NSButton *button = [[NSButton alloc]initWithFrame:CGRectMake(80, 200, 200, 80)];
    [button setTitle:@"make changed"];
    [button setAction:@selector(changeIconClick)];
    [self.view addSubview:button];
}

- (void)changeIconClick
{
    NSLog(@"click");
    
    NSString *path = @"/Users/administrator/Desktop/test";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL isExist = [fileManager fileExistsAtPath:path];
    if (!isExist) {
        BOOL isSuccess = [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
        if (isSuccess) {
            NSLog(@"createDirectory isSuccess");
            [self changeIcon:path];
        }else {
            NSLog(@"%@",error);
            NSLog(@"文件不存在，创建文件失败");
        }
    }else {
         [self changeIcon:path];
    }
}

- (void)changeIcon:(NSString *)path
{
    NSWorkspace *workSpace = [NSWorkspace sharedWorkspace];
    NSImage *image = [NSImage imageNamed:@"music"];
    BOOL success = [workSpace setIcon:image forFile:path options:NSExcludeQuickDrawElementsIconCreationOption];
    if (success) {
        NSLog(@"修改成功");
    }
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
