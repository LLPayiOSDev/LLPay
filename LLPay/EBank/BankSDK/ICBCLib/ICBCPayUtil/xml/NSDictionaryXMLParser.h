//
//  NSDictionaryXMLParser.h
//  XMLParser
//  ICBCiPhoneBank
//  Parse XML Data
//
//  Created by ShiyoungLee on 10-11-11.
//  Copyright 2010 ICBC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary(XMLParser)

+ (NSDictionary *)dictionaryFromXML:(NSString *)xmlString;

@end
