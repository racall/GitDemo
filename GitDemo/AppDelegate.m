//
//  AppDelegate.m
//  GitDemo
//
//  Created by MiniCreo on 12/20/17.
//  Copyright (c) 2017 MiniCreo. All rights reserved.
//

#import "AppDelegate.h"
#import <ObjectiveGit/ObjectiveGit.h>
#import <MMMarkdown/MMMarkdown.h>
@interface AppDelegate (){
    GTRepository *repo;
}

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"标题";
    notification.subtitle = @"小标题";
    NSDate *date=[NSDate date];
    notification.informativeText = [NSString stringWithFormat:@"%@",date];
    
//    // 设置通知提交的时间
//     notification.deliveryDate = [NSDate dateWithTimeIntervalSinceNow:5];
//     //设置通知的循环(必须大于1分钟，估计是防止软件刷屏)
//     NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//     [dateComponents setSecond:70];
//     notification.deliveryRepeatInterval = dateComponents;
    
    //只有当用户设置为提示模式时，才会显示按钮
    [notification setValue:@(YES) forKey:@"_showsButtons"];
    notification.hasActionButton = YES;
    notification.actionButtonTitle = @"OK";
    notification.otherButtonTitle = @"Cancel";
    //递交通知
    [[NSUserNotificationCenter defaultUserNotificationCenter] scheduleNotification:notification];
    //设置通知的代理
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
    
    
    
    NSURL *url=[NSURL fileURLWithPath:@"/Users/MiniCreo/gittest"];
    NSError *e=nil;
    repo = [GTRepository repositoryWithURL:url error:&e];
    GTReference *head = [repo headReferenceWithError:NULL];
    GTCommit *commit=[repo lookUpObjectByOID:head.targetOID error:NULL];
    [commit committer];
    //NSLog(@"%@",[commit ]);
    for (NSInteger i = 0; i < head.reflog.entryCount; i ++) {
        GTReflogEntry *entry = [head.reflog entryAtIndex:i];
        NSLog(@"%@",[entry updatedOID]);
    }
}
- (IBAction)clicked:(NSButton *)sender {
    NSError  *error;
    NSString *markdown   = @"# Example\nWhat a library!";
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:markdown error:&error];
    NSLog(@"%@",htmlString);
    [[web mainFrame] loadHTMLString:htmlString baseURL:nil];
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didDeliverNotification:(NSUserNotification *)notification
{
    NSLog(@"通知已经递交！");
}
- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification
{
    
    for (NSUserNotification *notify in [[NSUserNotificationCenter defaultUserNotificationCenter] scheduledNotifications])
    {
        [[NSUserNotificationCenter defaultUserNotificationCenter] removeScheduledNotification:notify];
    }
    NSLog(@"用户点击了通知！");
}
- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification
{
    //用户中心决定不显示该条通知(如果显示条数超过限制或重复通知等)，returen YES;强制显示
    return YES;
}

- (NSArray*)commitHistory {
    NSError *enumeratorError;
    GTEnumerator *enumerator = [[GTEnumerator alloc] initWithRepository:repo error:&enumeratorError];
    if (enumeratorError) {
        NSLog(@"Error creating enumerator for repo: %@", enumeratorError.localizedDescription);
        enumeratorError = nil;
    }
    
    GTReference *headRef = [repo headReferenceWithError:&enumeratorError];
    if (enumeratorError) {
        NSLog(@"Error getting head reference for repo: %@", enumeratorError.localizedDescription);
        enumeratorError = nil;
    }
    
    [enumerator pushSHA:headRef.targetOID.SHA error:&enumeratorError];
    if (enumeratorError) {
        NSLog(@"Error moving to headRef in repo: %@", enumeratorError.localizedDescription);
        enumeratorError = nil;
    }
    
    NSArray *commits = [enumerator allObjectsWithError:&enumeratorError];
    if (enumeratorError) {
        NSLog(@"Error getting commits for repo: %@", enumeratorError.localizedDescription);
        enumeratorError = nil;
    }
    
    return commits;
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
