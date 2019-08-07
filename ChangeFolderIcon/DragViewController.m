//
//  DragViewController.m
//  ChangeFolderIcon
//
//  Created by meiqing on 2019/8/7.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "DragViewController.h"
#import "DestinationView.h"

@interface DragViewController ()<DragDropViewDelegate>
@property (strong, nonatomic)NSTextField *statusLabel;
@property (strong, nonatomic)DestinationView *dView;
@end

@implementation DragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    
    [self addTipsLabel];
    
    self.dView = [[DestinationView alloc]initWithFrame:CGRectMake(50, 50, self.view.frame.size.width - 100, self.view.frame.size.height - 100)];
    
    self.dView.delegate = self;
    [self.view addSubview:self.dView];
    
    //    NSString *observedObject = @"com.changeIcon.shareData";
    // 处理Mac不同的进程之间的通知
    NSDistributedNotificationCenter *center =
    [NSDistributedNotificationCenter defaultCenter];
    [center addObserver: self
               selector: @selector(callbackWithNotification:)
                   name: @"PiaoYun Notification"
                 object: nil];
    [center addObserver: self
               selector: @selector(callbackWithNotification:)
                   name: @"PiaoYun Notification1"
                 object: nil];
    
    
    [self.dView addSubview:self.statusLabel];
    self.statusLabel.hidden = NO;
}

- (NSTextField *)statusLabel
{
    if (_statusLabel == nil) {
        _statusLabel = [[NSTextField alloc]init];
        _statusLabel.editable = NO;
        _statusLabel.bordered = NO; //不显示边框
        _statusLabel.backgroundColor = [NSColor clearColor]; //控件背景色
        _statusLabel.textColor = [NSColor blackColor];  //文字颜色
        _statusLabel.font = [NSFont boldSystemFontOfSize:18];
        _statusLabel.alignment = NSTextAlignmentCenter; //水平显示方式
        _statusLabel.maximumNumberOfLines = 2; //最多显示行数
        _statusLabel.frame = NSMakeRect(0, self.dView.frame.size.height/2, self.dView.frame.size.width, 30);
    }
    return _statusLabel;
}

- (void)addTipsLabel
{
    NSTextField *label0 = [[NSTextField alloc]init];
    label0.editable = NO;
    label0.bordered = NO; //不显示边框
    label0.backgroundColor = [NSColor clearColor]; //控件背景色
    label0.textColor = [NSColor blackColor];  //文字颜色
    label0.font = [NSFont boldSystemFontOfSize:20];
    label0.alignment = NSTextAlignmentRight; //水平显示方式
    label0.maximumNumberOfLines = 2; //最多显示行数
    label0.frame = NSMakeRect(40, self.view.frame.size.height - 30, 400, 30);
    label0.stringValue = @"将需要的文件拖拽进入虚线区域即可完成修改";
    
    [self.view addSubview:label0];
   
}

//回调：
- (void)callbackWithNotification:(NSNotification *)myNotification;
{
    NSLog(@"Notification Received");
    NSString *str = (NSString *)myNotification.object;
    NSArray *array = [str componentsSeparatedByString:@";"];
    NSString *path = array[0];
    NSString *imageName = array[1];
    [self changeIcon:path withImageName:imageName];
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
            [self changeIcon:path withImageName:@"music"];
        }else {
            NSLog(@"%@",error);
            NSLog(@"文件不存在，创建文件失败");
        }
    }else {
        [self changeIcon:path withImageName:@"music"];
    }
}

- (void)changeIcon:(NSString *)path withImageName:(NSString *)iamgeaName
{
    NSWorkspace *workSpace = [NSWorkspace sharedWorkspace];
    [workSpace setIcon:nil forFile:path options:NSExcludeQuickDrawElementsIconCreationOption];
    NSImage *image = [NSImage imageNamed:iamgeaName];
    BOOL success = [workSpace setIcon:image forFile:path options:NSExcludeQuickDrawElementsIconCreationOption];
    if (success) {
        self.statusLabel.stringValue = @"修改成功";
        [self performSelector:@selector(hideStatusLabel) withObject:nil afterDelay:2];
        self.statusLabel.hidden = NO;
        NSLog(@"修改成功");
    }
}

- (void)hideStatusLabel
{
    self.statusLabel.stringValue = @"";
    self.statusLabel.hidden = YES;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}


@end

