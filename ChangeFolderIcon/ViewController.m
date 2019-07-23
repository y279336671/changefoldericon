//
//  ViewController.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/7/22.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "ViewController.h"
#import "DestinationView.h"

@interface ViewController()<DragDropViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
//    NSButton *button = [[NSButton alloc]initWithFrame:CGRectMake(80, 200, 200, 80)];
//    [button setTitle:@"make changed"];
//    [button setAction:@selector(changeIconClick)];
//    [self.view addSubview:button];
    
    
    DestinationView *dView = [[DestinationView alloc]initWithFrame:CGRectMake(0, 0, 500, 500)];
    dView.delegate = self;
    [self.view addSubview:dView];
}

/***
 第五步：实现dragdropview的代理函数，如果有数据返回就会触发这个函数
 ***/
-(void)dragDropViewFileList:(NSArray *)fileList{
    //如果数组不存在或为空直接返回不做处理（这种方法应该被广泛的使用，在进行数据处理前应该现判断是否为空。）
    if(!fileList || [fileList count] <= 0)return;
    //在这里我们将遍历这个数字，输出所有的链接，在后台你将会看到所有接受到的文件地址
    for (int n = 0 ; n < [fileList count] ; n++) {
        NSString *fileName = [fileList objectAtIndex:n];
        NSLog(@">>> %@",fileName);
        [self changeIconClick:fileName];
    }
    
}


- (void)changeIconClick:(NSString *)path
{
    NSLog(@"click");
    
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
