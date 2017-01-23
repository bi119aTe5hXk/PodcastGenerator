//
//  MainViewController.m
//  PodcastGenerator
//
//  Created by bi119aTe5hXk on 2016/12/10.
//  Copyright © 2016 HT&L. All rights reserved.
//

#import "MainViewController.h"
#import "PCXMLGen.h"
#import "FileHelper.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    userdefaults = [NSUserDefaults standardUserDefaults];
    //filepath = [userdefaults valueForKey:@"filepath"];
    
    [self.tableView setTarget:self];
    //[self updatexml];
}
-(IBAction)refreshbtn:(id)sender{
    [self updatexml];
    
}
-(void)setupTimer{
    if (!timer) {
        NSLog(@"Timer On!");
        timer = [NSTimer scheduledTimerWithTimeInterval:autoUpdateTime*60
                                                 target:self
                                               selector:@selector(updatexml)
                                               userInfo:nil
                                                repeats:YES];
    }
    
}
-(void)checkdir{
    
    NSArray *fileslist = [[FileHelper alloc] fileNamesAtDirectoryPath:filepath];
    NSLog(@"filelist:%@",fileslist);
    
    fileslist1 = [[NSMutableArray alloc] initWithArray:fileslist];
    [self.tableView reloadData];
}

-(void)updatexml{
    filepath = [userdefaults valueForKey:@"filepath"];
    urlheader = [userdefaults valueForKey:@"urlheader"];
    xmlfilepath = [userdefaults valueForKey:@"xmlfilepath"];
    autoUpdateTime = [userdefaults integerForKey:@"AutoUpdateTime"];
    isAutoUpdateEnabled = [userdefaults boolForKey:@"AutoUpdate"];
    if (filepath.length <= 0 || xmlfilepath.length <= 0 || urlheader.length <= 0) {
        NSRunAlertPanel(@"Error!!Files path or XML save path or URL header is empty! ", @"Please open Prefernce to check your settings!",nil,nil,nil);
        return;
    }
    
    
    [self checkdir];
    if (isAutoUpdateEnabled == YES) {
        [self setupTimer];
    }else{
        [timer invalidate];
        timer = nil;
    }
    
    NSString *mtitle = [userdefaults valueForKey:@"main_title"];
    NSString *mdescription = [userdefaults valueForKey:@"main_description"];
    NSString *mauthor = [userdefaults valueForKey:@"main_author"];
    NSString *mlanguage = [userdefaults valueForKey:@"main_language"];
    NSString *mlink = [userdefaults valueForKey:@"main_link"];
    NSString *mcopyright = [userdefaults valueForKey:@"main_copyright"];
    NSString *msubtitle = [userdefaults valueForKey:@"main_subtitle"];
    NSString *msummary = [NSString stringWithFormat:@"<![CDATA[%@]>",[userdefaults valueForKey:@"main_summary"]];
    NSString *martworkurl = [userdefaults valueForKey:@"main_artwork"];
    BOOL isExplicitContent = [userdefaults boolForKey:@"explicitcontent"];
    NSString *isECstr = @"no";
    if (isExplicitContent == YES) {
        isECstr = @"yes";
    }else{
        isECstr = @"no";
    }
    
    NSDictionary *mdic = [NSDictionary dictionaryWithObjectsAndKeys:
                          mtitle,@"title",
                          mlink,@"link",
                          mlanguage,@"language",
                          mcopyright,@"copyright",
                          msubtitle,@"itunes:subtitle",
                          mauthor,@"itunes:author",
                          msummary,@"itunes:summary",
                          mdescription,@"description",
                          martworkurl,@"itunes:image",
                          isECstr,@"itunes:explicit",
                          @"TV &amp; Film",@"itunes:category",
                          
                          nil];
    
    
    
    
    NSArray *items = [[NSArray alloc] init];
    //[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"killall 9",@"title", nil], nil];
    //items = [items arrayByAddingObject:]
    for (int i = 0; i < [fileslist1 count]; i++) {
        NSString *filename = [fileslist1 objectAtIndex:i];
        
        
        NSString *encodefilename = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)filename,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",kCFStringEncodingUTF8);
        
        NSString *fileurl =[NSString stringWithFormat:@"%@/%@",urlheader,encodefilename];
        NSString *filetype = @"";
        if ([[filename pathExtension] isEqualToString:@"m4a"]){
            filetype = @"audio/x-m4a";
        }else if([[filename pathExtension] isEqualToString:@"m4v"]){
            filetype = @"video/x-m4v";
        }else if([[filename pathExtension] isEqualToString:@"mp3"]){
            filetype = @"audio/mpeg";
        }else if([[filename pathExtension] isEqualToString:@"mp4"]){
            filetype = @"video/mp4";
        }else if([[filename pathExtension] isEqualToString:@"mov"]){
            filetype = @"video/quicktime";
        }else if([[filename pathExtension] isEqualToString:@"pdf"]){
            filetype = @"application/pdf";
        }else if([[filename pathExtension] isEqualToString:@"epub"]){
            filetype = @"document/x-epub";
        }
        NSString *filepath1 = [NSString stringWithFormat:@"%@/%@",filepath,filename];
        NSInteger filesize = [[FileHelper alloc] filesizeWithPath:filepath1];
        NSDictionary *detail = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%ld",(long)filesize],@"length",
                                filetype,@"type",
                                fileurl,@"url",
                                nil];
        
        items = [items arrayByAddingObject:
                 [NSDictionary dictionaryWithObjectsAndKeys:
                  filename,@"title",
                  [NSDictionary dictionaryWithObjectsAndKeys:detail,@"detail", nil],@"enclosure",
                  isECstr,@"itunes:explicit",
                  fileurl,@"guid",
                  nil]];
    }
    
    NSXMLDocument *xmldoc = [[PCXMLGen alloc] PodCastGenWithXMLInfo:mdic WithItems:items];
    
    [[PCXMLGen alloc] saveXML:xmldoc fileinPath:xmlfilepath];
    
    
    
    
    
    
    
    
}
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [fileslist1 count];
}
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    //NSDictionary *dictionary = [fileslist objectAtIndex:row];
    NSString *identifier = [tableColumn identifier];
    NSTableCellView *cellView = [[NSTableCellView alloc] init];
    
    if ([identifier isEqualToString:@"CountCell"]) {
        cellView = [tableView makeViewWithIdentifier:identifier owner:self];
        cellView.textField.stringValue = [NSString stringWithFormat:@"%ld",(long)++row];
        cellView.imageView = nil;
        return cellView;
        
    }else if ([identifier isEqualToString:@"TimeCell"]) {
        cellView = [tableView makeViewWithIdentifier:identifier owner:self];
        cellView.textField.stringValue = @"time";
        return cellView;
    }else if ([identifier isEqualToString:@"TitleCell"]) {
        cellView = [tableView makeViewWithIdentifier:identifier owner:self];
        cellView.textField.stringValue = [fileslist1 objectAtIndex:row];
        return cellView;
    }else {
        NSLog(@"Unhandled table column identifier %@", identifier);
    }
    
    
    return nil;
}
-(IBAction)OpenLocationbtn:(id)sender{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL fileURLWithPath:filepath]];
}
-(IBAction)OpenWebbtn:(id)sender{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:urlheader]];
}



@end
