//
//  AppDelegate.m
//  PodcastGenerator
//
//  Created by bi119aTe5hXk on 2016/11/20.
//  Copyright © 2016 HT&L. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
    if(!flag)
    {
        for(id const window in theApplication.windows)
        {
            [window makeKeyAndOrderFront:self];
        }
    }
    return YES;
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSLog(@"Init...");
    NSLog(@" _____       _             _   _____                     _           ");
    NSLog(@"|  _  |___ _| |___ ___ ___| |_|   __|___ ___ ___ ___ ___| |_ ___ ___ ");
    NSLog(@"|   __| . | . |  _| .'|_ -|  _|  |  | -_|   | -_|  _| .'|  _| . |  _|");
    NSLog(@"|__|  |___|___|___|__,|___|_| |_____|___|_|_|___|_| |__,|_| |___|_|  ");
    NSLog(@"Product by ©bi119aTe5hXk 2016-2017.");
    
    // Insert code here to initialize your application
    userdefaults = [NSUserDefaults standardUserDefaults];
    
    
    
    //basic
    [userdefaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:@"", @"filepath",
                                    @"", @"xmlfilepath",
                                    @"", @"urlheader",
                                    [NSNumber numberWithInt:60], @"AutoUpdateTime",
                                    [NSNumber numberWithBool:YES],@"AutoUpdate",
                                    nil]];
    [userdefaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], @"autoscancheck",nil]];
    
    //info
    [userdefaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:@"", @"main_title",
                                    @"", @"main_description",
                                    @"", @"main_author",
                                    @"", @"main_language",
                                    @"http://127.0.0.1/podcast/", @"main_link",
                                    @"", @"main_copyright",
                                    @"", @"main_subtitle",
                                    @"", @"main_summary",
                                    @"", @"main_artwork",
                                    [NSNumber numberWithBool:NO], @"explicitcontent",
                                    
                                    nil]];
    
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
