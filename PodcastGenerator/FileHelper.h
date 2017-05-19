//
//  FileHelper.h
//  PodcastGenerator
//
//  Copied & Edited by bi119aTe5hXk on 2017/01/17.
//  NO Copyright © 2017 HT&L. All rights not reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>

@interface FileHelper : NSObject
/* tmp */
- (NSString*)temporaryDirectory;
/* /tmp/fileName */
- (NSString*)temporaryDirectoryWithFileName:(NSString*)fileName;

/* /Documents */
- (NSString*)documentDirectory;
/* /Documents/fileName */
- (NSString*)documentDirectoryWithFileName:(NSString*)fileName;

/* pathのファイルが存在しているか */
- (BOOL)fileExistsAtPath:(NSString*)path;

/* pathのファイルがelapsedTimeを超えているか */
- (BOOL)isElapsedFileModificationDateWithPath:(NSString*)path elapsedTimeInterval:(NSTimeInterval)elapsedTime;

/* directoryPath内のextension(拡張子)と一致する全てのファイル名 */
- (NSArray*)fileNamesAtDirectoryPath:(NSString*)directoryPath;

/* pathのファイルを削除 */
- (BOOL)removeFilePath:(NSString*)path;


-(NSInteger)filesizeWithPath:(NSString*)path;
-(NSDate*)fileModifiedDateWithPath:(NSString*)path;
-(NSDate*)fileAddedDateWithPath:(NSString*)path;
-(NSString*)mediaFileDurationWtihPath:(NSString*)path;
@end
