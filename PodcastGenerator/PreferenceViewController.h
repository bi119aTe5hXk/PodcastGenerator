//
//  PreferenceViewController.h
//  PodcastGenerator
//
//  Created by bi119aTe5hXk on 2016/12/11.
//  Copyright © 2016 bi119aTe5hXk. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferenceViewController : NSViewController{
    NSUserDefaults *userdefaults;
    NSURL *filepath;
    NSURL *xmlpath;
    BOOL autoupdateenabled;
    BOOL isExplicitContent;
}
@property (strong, nonatomic) IBOutlet NSPathControl *filepathcontrol;
@property (strong, nonatomic) IBOutlet NSPathControl *xmlpathcontrol;
@property (strong, nonatomic) IBOutlet NSTextField *urlheaderfield;
@property (strong, nonatomic) IBOutlet NSButton *autoupdatecheckbox;
@property (strong, nonatomic) IBOutlet NSTextField *countdowntimefield;

@property (strong, nonatomic) IBOutlet NSTextField *titletf;
@property (strong, nonatomic) IBOutlet NSTextField *descriptiontf;
@property (strong, nonatomic) IBOutlet NSTextField *authortf;
@property (strong, nonatomic) IBOutlet NSTextField *languagetf;
@property (strong, nonatomic) IBOutlet NSTextField *linktf;
@property (strong, nonatomic) IBOutlet NSTextField *copyrighttf;
@property (strong, nonatomic) IBOutlet NSTextField *subtitletf;
@property (strong, nonatomic) IBOutlet NSTextField *summarytf;
@property (strong, nonatomic) IBOutlet NSTextField *artworkurltf;
@property (strong, nonatomic) IBOutlet NSButton *explicitcb;
-(IBAction)setExplicitCB:(id)sender;




-(IBAction)setfileLocationbtn:(id)sender;
-(IBAction)setxmlfileLocationbtn:(id)sender;
-(IBAction)setAutoUpdateCB:(id)sender;




@end
