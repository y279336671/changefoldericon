//
//  Tools.m
//  ChangeFolderIcon
//
//  Created by 杨贺 on 2019/8/6.
//  Copyright © 2019 meiqing. All rights reserved.
//

#import "Tools.h"

@implementation Tools
//isAuto true 开机自动启动  false关闭开机自动启动
+(void)setLaunchAgents:(BOOL)isAuto{
    NSString* launchFolder = [NSString stringWithFormat:@"%@/Library/LaunchAgents",NSHomeDirectory()];
    NSString * bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleIdentifierKey];
    
    NSString* dstLaunchPath = [launchFolder stringByAppendingFormat:@"/%@.plist",bundleID];
    
    NSLog(@"dstLaunchPath : %@",dstLaunchPath);
    //dstLaunchPath : /Users/administrator/Library/LaunchAgents/com.melissashu.www.MSLaunchAgentsLogin.plist
    
    NSFileManager* fm = [NSFileManager defaultManager];
    BOOL isDir = NO;
    //todo 已经存在启动项中，就不必再创建  这个判断应该有问题，当已经纯在的时候想设置成开机不自动启动貌似也不继续往下执行代码了，需要验证一下
    if ([fm fileExistsAtPath:dstLaunchPath isDirectory:&isDir] && !isDir) {
        return;
    }
    //下面是一些配置
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    [arr addObject:[[NSBundle mainBundle] executablePath]];
    [arr addObject:@"-runMode"];
    [arr addObject:@"autoLaunched"];
    [dict setObject:[NSNumber numberWithBool:isAuto] forKey:@"RunAtLoad"];
    [dict setObject:bundleID forKey:@"Label"];
    [dict setObject:arr forKey:@"ProgramArguments"];
    isDir = NO;
    if (![fm fileExistsAtPath:launchFolder isDirectory:&isDir] && isDir) {
        [fm createDirectoryAtPath:launchFolder withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSLog(@"dict : %@",dict);
    
    [dict writeToFile:dstLaunchPath atomically:NO];
}

+(NSDictionary *)getAppInfo{
    return [[NSBundle mainBundle]infoDictionary];
}
@end
