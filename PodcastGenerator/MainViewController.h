//
//  MainViewController.h
//  PodcastGenerator
//
//  Created by bi119aTe5hXk on 2016/12/10.
//  Copyright © 2016 bi119aTe5hXk. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainViewController : NSViewController<NSTableViewDelegate,NSTableViewDataSource>{
    NSUserDefaults *userdefaults;
    NSString *filepath;
    NSString *xmlfilepath;
    NSString *urlheader;
    
    
    NSFileManager *fileManager;
    //NSDateFormatter *formater;
    BOOL isAutoUpdateEnabled;
    NSInteger autoUpdateTime;
    NSTimer *timer;
    NSMutableArray *fileslist1;
}

@property (nonatomic, strong) IBOutlet NSTableView *tableView;
@property (nonatomic, strong) IBOutlet NSTextField *updatelabel;
-(IBAction)refreshbtn:(id)sender;
-(IBAction)OpenLocationbtn:(id)sender;
-(IBAction)OpenWebbtn:(id)sender;

@end
