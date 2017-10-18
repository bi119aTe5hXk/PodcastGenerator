//
//  PCXMLGen.m
//  PodcastGenerator
//
//  Created by bi119aTe5hXk on 2017/01/11.
//  Copyright © 2017 bi119aTe5hXk. All rights reserved.
//

//https://help.apple.com/itc/podcasts_connect/#/itcb54353390

#import "PCXMLGen.h"

@implementation PCXMLGen

-(NSXMLElement *)nodeWithName:(NSString *)name WithValue:(NSString *)value{
    NSXMLElement *element = [NSXMLNode elementWithName:name];
    [element setStringValue:value];
    return element;
}

-(NSXMLDocument *)PodCastGenWithXMLInfo:(NSDictionary *)info WithItems:(NSArray *)items{
    if ([info count] <= 0  || [items count] <= 0) {
        return nil;
    }
    
    NSXMLElement* rss = [NSXMLNode elementWithName:@"rss"];
    NSXMLDocument* xmlDoc = [[NSXMLDocument alloc] initWithRootElement:rss];
    [xmlDoc setVersion:@"1.0"];
    [xmlDoc setCharacterEncoding:@"UTF-8"];
    [rss addAttribute:[NSXMLNode attributeWithName:@"version" stringValue:@"2.0"]];
    [rss addAttribute:[NSXMLNode attributeWithName:@"xmlns:itunes" stringValue:@"http://www.itunes.com/dtds/podcast-1.0.dtd"]];
    
    //channel
    NSXMLElement *channel = [NSXMLNode elementWithName:@"channel"];
    
    
    //rss info
    
    for (NSString *key in info) {
        id value = info[key];
        if ([key isEqualToString:@"itunes:image"]) {
            NSXMLElement *imageurl = [NSXMLNode elementWithName:@"itunes:image"];
            [imageurl addAttribute:[NSXMLNode attributeWithName:@"href" stringValue:value]];
            [channel addChild:imageurl];
        }else if ([key isEqualToString:@"itunes:category"]){
            //to do 
            
        }else{
            [channel addChild:[self nodeWithName:key WithValue:value]];
        }
    }
    
    //item
    
    
    for (int i = 0; i < [items count]; i++) {
        NSDictionary *dic = [items objectAtIndex:i];
        NSXMLElement *item = [NSXMLNode elementWithName:@"item"];
        for (NSString *key in dic) {
            id value = dic[key];
            if ([key isEqualToString: @"itunes:image"]) {
                NSXMLElement *imageurl = [NSXMLNode elementWithName:@"itunes:image"];
                [imageurl addAttribute:[NSXMLNode attributeWithName:@"href" stringValue:value]];
                [item addChild:imageurl];
            }else if ([key isEqualToString: @"enclosure"]){
                NSXMLElement *enclosure = [NSXMLNode elementWithName:@"enclosure"];
                NSDictionary *detail = [value valueForKey:@"detail"];
                [enclosure addAttribute:[NSXMLNode attributeWithName:@"length" stringValue:[detail valueForKey:@"length"]]];
                [enclosure addAttribute:[NSXMLNode attributeWithName:@"type" stringValue:[detail valueForKey:@"type"]]];
                [enclosure addAttribute:[NSXMLNode attributeWithName:@"url" stringValue:[detail valueForKey:@"url"]]];
                [item addChild:enclosure];
            }else{
                [item addChild:[self nodeWithName:key WithValue:value]];
            }
        }
        [channel addChild:item];
    }
    
    [rss addChild:channel];
    
    
    NSLog(@"%@",xmlDoc);
    
    return xmlDoc;
}
-(void)saveXML:(NSXMLDocument*)xml fileinPath:(NSString*)path{
    NSString *pathwithname = [NSString stringWithFormat:@"%@/podcast.xml",path];
    NSData* xmlData = [xml XMLDataWithOptions:NSXMLNodePrettyPrint];
    [xmlData writeToFile:pathwithname atomically:YES];
    
    
}


@end
