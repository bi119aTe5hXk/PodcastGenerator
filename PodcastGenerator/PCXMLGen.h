//
//  PCXMLGen.h
//  PodcastGenerator
//
//  Created by bi119aTe5hXk on 2017/01/11.
//  Copyright © 2017 bi119aTe5hXk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCXMLGen : NSObject


-(NSXMLDocument *)PodCastGenWithXMLInfo:(NSDictionary *)info WithItems:(NSArray *)items;

-(void)saveXML:(NSXMLDocument*)xml fileinPath:(NSString*)path;
@end
