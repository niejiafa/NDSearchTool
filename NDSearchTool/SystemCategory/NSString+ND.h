//
//  NSString+ND.h
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ND)

#pragma mark - Data

- (NSData *)nd_data;

#pragma mark - UI

- (CGSize)nd_textSize:(UIFont *)font;

#pragma mark - Remove characters

- (NSString *)nd_trimWhitespace; // 删除两边空格
- (NSString *)nd_trimNewline; // 删除回车
- (NSString *)nd_trimWhitespaceAndNewline; // 删除两边空格和回车

#pragma mark - UUID

+ (NSString *)nd_UUID;

#pragma mark - MD5

- (NSString *)nd_md5String;
- (NSData *)nd_md5Data;

#pragma mark - Base64

- (NSString *)nd_base64EncodedString;
- (NSData *)nd_base64EncodedData;
- (NSString *)nd_base64DecodedString;
- (NSData *)nd_base64DecodedData;

#pragma mark - JSON

- (NSDictionary *)nd_dictionaryWithJSON;

#pragma mark - URL

- (NSString*)nd_urlEncodedString;
- (NSString*)nd_urlDecodedString;

- (NSString *)nd_urlEncodeUsingEncoding:(CFStringEncoding)encoding;
- (NSString *)nd_urlDecodeUsingEncoding:(CFStringEncoding)encoding;

// http://www.example.com/index.php?key1=value1&key2=value2 , the query string is key1=value1&key2=value2. Self is "key1=value1&key2=value2"
- (NSDictionary *)nd_dictionaryWithURLQuery;

#pragma mark - SubString

- (NSString *)nd_subStringBeforeFirstSeparator:(NSString *)separator;
- (NSString *)nd_subStringAfterFirstSeparator:(NSString *)separator;

- (NSArray *)nd_stringBetweenTheSameString:(NSString *)separator;

@end
