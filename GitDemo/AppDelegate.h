//
//  AppDelegate.h
//  GitDemo
//
//  Created by MiniCreo on 12/20/17.
//  Copyright (c) 2017 MiniCreo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
@interface AppDelegate : NSObject <NSApplicationDelegate,NSUserNotificationCenterDelegate>{
    
    __weak IBOutlet WebView *web;

}

@end

