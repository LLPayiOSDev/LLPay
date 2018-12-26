//
//  NSDictionaryXMLParser.h
//  XMLParser
//  ICBCiPhoneBank
//  Parse XML Data
//
//  Created by ShiyoungLee on 10-11-11.
//  Copyright 2010 ICBC. All rights reserved.
//

#import "NSDictionaryXMLParser.h"
#import "GDataXMLNode.h"


@interface NSDictionary(PrivateXMLParser)

+ (NSDictionary *)dictionaryWithXMLElement:(GDataXMLElement *)element;

@end

@interface NSArray(PrivateXMLParser)

+ (NSArray *)arrayWithXMLElement:(GDataXMLElement *)element;

@end


@implementation NSDictionary(XMLParser)

+ (NSDictionary *)dictionaryFromXML:(NSString *)xmlString {
	NSError          *error         = nil;
	GDataXMLDocument *document      = [[GDataXMLDocument alloc] initWithXMLString:xmlString options:0 error:&error];
	NSDictionary     *newDictionary = [NSDictionary dictionaryWithXMLElement:[document rootElement]];
	return newDictionary;
}

@end


@implementation NSDictionary(PrivateXMLParser)

+ (NSDictionary *)dictionaryWithXMLElement:(GDataXMLElement *)element {
	NSMutableDictionary *newDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	NSArray *fieldElements = [element elementsForName:@"Field"];
	for (GDataXMLElement *fieldElement in fieldElements) {
		[newDictionary setObject:[fieldElement stringValue] forKey:[[fieldElement attributeForName:@"id"] stringValue]];
	}
	
	NSArray *mapElements = [element elementsForName:@"Map"];
	for (GDataXMLElement *mapElement in mapElements) {
		[newDictionary setObject:[NSDictionary dictionaryWithXMLElement:mapElement] forKey:[[mapElement attributeForName:@"id"] stringValue]];
	}
	
	NSArray *listElements = [element elementsForName:@"List"];	
	for (GDataXMLElement *listElement in listElements) {
		[newDictionary setObject:[NSArray arrayWithXMLElement:listElement] forKey:[[listElement attributeForName:@"id"] stringValue]];		
	}
	
	return newDictionary;
}

@end


@implementation NSArray(PrivateXMLParser)

+ (NSArray *)arrayWithXMLElement:(GDataXMLElement *)element {
	NSMutableArray *newArray = [NSMutableArray  arrayWithCapacity:0];
	
	NSArray *fieldElements = [element elementsForName:@"Field"];
	for (GDataXMLElement *fieldElement in fieldElements) {
		[newArray addObject:[fieldElement stringValue]];
	}
	
	NSArray *mapElements = [element elementsForName:@"Map"];
	for (GDataXMLElement *mapElement in mapElements) {
		[newArray addObject:[NSDictionary dictionaryWithXMLElement:mapElement]];
	}
	
	NSArray *listElements = [element elementsForName:@"List"];	
	for (GDataXMLElement *listElement in listElements) {
		[newArray addObject:[NSArray arrayWithXMLElement:listElement]];
	}
	return newArray;
}

@end