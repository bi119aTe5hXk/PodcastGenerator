//
//  PreferenceViewController.m
//  PodcastGenerator
//
//  Created by bi119aTe5hXk on 2016/12/11.
//  Copyright © 2016 HT&L. All rights reserved.
//

#import "PreferenceViewController.h"

@interface PreferenceViewController ()

@end

@implementation PreferenceViewController


-(void)viewWillDisappear{
    [self saveSettings];
}
-(void)saveSettings{
    if ([self.countdowntimefield integerValue] <= 0) {
        [userdefaults setInteger:60 forKey:@"AutoUpdateTime"];
    }else{
        [userdefaults setInteger:[self.countdowntimefield integerValue] forKey:@"AutoUpdateTime"];
    }
    
    
    [userdefaults setValue:[self.titletf stringValue] forKey:@"main_title"];
    [userdefaults setValue:[self.descriptiontf stringValue] forKey:@"main_description"];
    [userdefaults setValue:[self.authortf stringValue] forKey:@"main_author"];
    [userdefaults setValue:[self.languagetf stringValue] forKey:@"main_language"];
    [userdefaults setValue:[self.linktf stringValue] forKey:@"main_link"];
    [userdefaults setValue:[self.copyrighttf stringValue] forKey:@"main_copyright"];
    [userdefaults setValue:[self.subtitletf stringValue] forKey:@"main_subtitle"];
    [userdefaults setValue:[self.summarytf stringValue] forKey:@"main_summary"];
    [userdefaults setValue:[self.artworkurltf stringValue] forKey:@"main_artwork"];
    
    [userdefaults setValue:[self.urlheaderfield stringValue] forKey:@"urlheader"];
    
    [userdefaults synchronize];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    userdefaults = [NSUserDefaults standardUserDefaults];
    [self loadSettings];
}
-(void)loadSettings{
    self.urlheaderfield.stringValue = [userdefaults valueForKey:@"urlheader"];
    self.titletf.stringValue = [userdefaults valueForKey:@"main_title"];
    self.descriptiontf.stringValue = [userdefaults valueForKey:@"main_description"];
    self.authortf.stringValue = [userdefaults valueForKey:@"main_author"];
    self.languagetf.stringValue = [userdefaults valueForKey:@"main_language"];
    self.linktf.stringValue = [userdefaults valueForKey:@"main_link"];
    self.copyrighttf.stringValue = [userdefaults valueForKey:@"main_copyright"];
    self.subtitletf.stringValue = [userdefaults valueForKey:@"main_subtitle"];
    self.summarytf.stringValue = [userdefaults valueForKey:@"main_summary"];
    self.artworkurltf.stringValue = [userdefaults valueForKey:@"main_artwork"];
    autoupdateenabled = [userdefaults boolForKey:@"autoscancheck"];
    self.countdowntimefield.integerValue = [userdefaults integerForKey:@"AutoUpdateTime"];
    isExplicitContent = [userdefaults boolForKey:@"explicitcontent"];
    
    NSString *filepathstr = [userdefaults valueForKey:@"filepath"];
    //NSLog(@"path:%@",pathstr);
    if (filepathstr.length > 0) {
        filepath = [NSURL fileURLWithPath:[filepathstr stringByExpandingTildeInPath]];
        [self.filepathcontrol setURL:filepath];
    }
    NSString *xmlpathstr = [userdefaults valueForKey:@"xmlfilepath"];
    if (xmlpathstr.length > 0) {
        xmlpath = [NSURL fileURLWithPath:[xmlpathstr stringByExpandingTildeInPath]];
        [self.xmlpathcontrol setURL:xmlpath];
    }
    
    
    if (autoupdateenabled == YES) {
        [self.autoupdatecheckbox setState:NSOnState];
    }else{
        [self.autoupdatecheckbox setState:NSOffState];
    }
    if (isExplicitContent == YES) {
        [self.explicitcb setState:NSOnState];
    }else{
        [self.explicitcb setState:NSOffState];
    }
    
}

-(IBAction)setfileLocationbtn:(id)sender{
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.canChooseFiles       = NO;
    openPanel.canChooseDirectories = YES;
    openPanel.prompt               = @"OK";
    if ([openPanel runModal] == NSModalResponseOK) {
        [userdefaults setValue:[[openPanel URL] path] forKey:@"filepath"];
        [userdefaults synchronize];
        [self loadSettings];
    }

}
-(IBAction)setxmlfileLocationbtn:(id)sender{
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.canChooseFiles       = NO;
    openPanel.canChooseDirectories = YES;
    openPanel.prompt               = @"OK";
    if ([openPanel runModal] == NSModalResponseOK) {
        [userdefaults setValue:[[openPanel URL] path] forKey:@"xmlfilepath"];
        [userdefaults synchronize];
        [self loadSettings];
    }
}
-(IBAction)setAutoUpdateCB:(id)sender{
    if (autoupdateenabled == YES) {
        autoupdateenabled = NO;
        [self.autoupdatecheckbox setState:NSOffState];
        [self.countdowntimefield setEnabled:NO];
        [userdefaults setBool:NO forKey:@"AutoUpdate"];
    }else{
        autoupdateenabled = YES;
        [self.autoupdatecheckbox setState:NSOnState];
        [self.countdowntimefield setEnabled:YES];
        [userdefaults setBool:YES forKey:@"AutoUpdate"];
    }
}
-(IBAction)setExplicitCB:(id)sender{
    if (isExplicitContent == YES) {
        isExplicitContent = NO;
        [self.explicitcb setState:NSOffState];
        [userdefaults setBool:NO forKey:@"explicitcontent"];
    }else{
        isExplicitContent = YES;
        [self.explicitcb setState:NSOnState];
        [userdefaults setBool:YES forKey:@"explicitcontent"];
    }
}
@end
