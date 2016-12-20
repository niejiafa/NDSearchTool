//
//  NSString+ND.m
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import "NSString+ND.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ND)

#pragma mark - Data

- (NSData *)nd_data
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - UI

- (CGSize)nd_textSize:(UIFont *)font
{
    if ([self length] <= 0)
    {
        return CGSizeZero;
    }
    
    CGSize size;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    size = [self sizeWithAttributes:@{NSFontAttributeName:font}];
#else
    size = [self sizeWithFont:font];
#endif
    
    return size;
}

#pragma mark - Remove characters

- (NSString *)nd_trimWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)nd_trimNewline;
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)nd_trimWhitespaceAndNewline;
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - UUID

+ (NSString *)nd_UUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);
    
    CFRelease(uuidRef);
    
    return (__bridge_transfer NSString *)uuid;
}

#pragma mark - MD5

- (NSString *)nd_md5String
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int) strlen(cStr), result);
    NSString *md5String = [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    return md5String;
}

- (NSData *)nd_md5Data
{
    return [[self nd_md5String] nd_data];
}

#pragma mark - Base64

- (NSString *)nd_base64EncodedString
{
#warning - parameter right?
    NSString *base64EncodedString = [[self nd_data] base64EncodedStringWithOptions:0];
    return base64EncodedString;
}

- (NSData *)nd_base64EncodedData
{
    NSData *base64EncodedData = [[self nd_data] base64EncodedDataWithOptions:0];
    return base64EncodedData;
}

- (NSString *)nd_base64DecodedString
{
    NSString *base64DecodedString = [[NSString alloc] initWithData:[self nd_base64DecodedData] encoding:NSUTF8StringEncoding];
    return base64DecodedString;
}

- (NSData *)nd_base64DecodedData
{
    NSData *base64DecodedData = [[NSData alloc] initWithBase64EncodedData:[self nd_data] options:0];
    return base64DecodedData;
}

#pragma mark - JSON

- (NSDictionary *)nd_dictionaryWithJSON
{
    NSData *data = [self nd_data];
    if (!data)
    {
        return nil;
    }
    
    NSError *error;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                                  error:&error];
    
    if (error)
    {
        NSAssert(NO, @"From data to JSON object error: %@", error);
    }
    
    return result;
}

#pragma mark - URL

- (NSString*)nd_urlEncodedString
{
    return [self nd_urlEncodeUsingEncoding:kCFStringEncodingUTF8];
}

- (NSString*)nd_urlDecodedString
{
    return [self nd_urlDecodeUsingEncoding:kCFStringEncodingUTF8];
}

- (NSString *)nd_urlEncodeUsingEncoding:(CFStringEncoding)encoding
{
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          encoding);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    
    return encodedString;
}

- (NSString *)nd_urlDecodeUsingEncoding:(CFStringEncoding)encoding
{
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef) self,
                                                                                          CFSTR(""),
                                                                                          encoding);
    
    
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
    
    if (decodedString)
    {
        // We need to replace "+" with " " because the CF method above doesn't do it
        decodedString = [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    }
    
    return decodedString;
}

- (NSDictionary *)nd_dictionaryWithURLQuery
{
    NSArray * params = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary * ret = [NSMutableDictionary dictionary];
    for (NSString * param in params)
    {
        NSRange range = [param rangeOfString:@"="];
        if (range.location != NSNotFound)
        {
            NSString * key = [param substringToIndex:range.location];
            NSString * value = [param substringFromIndex:range.location + 1];
            [ret setValue:value forKey:key];
        }
    }
    return ret;
}

#pragma mark - SubString

- (NSString *)nd_subStringBeforeFirstSeparator:(NSString *)separator_
{
    NSRange range = [self rangeOfString:separator_];
    if (NSNotFound == range.location)
    {
        return nil;
    }
    
    NSString *str = [self substringToIndex:range.location];
    return str;
}

- (NSString *)nd_subStringAfterFirstSeparator:(NSString *)separator_
{
    NSRange range = [self rangeOfString:separator_];
    if (NSNotFound == range.location)
    {
        return nil;
    }
    
    NSString *str = [self substringFromIndex:range.location + range.length];
    return str;
}

- (NSArray *)nd_stringBetweenTheSameString:(NSString *)separator
{
    NSArray *array = [self componentsSeparatedByString:separator];
    NSMutableArray *resultMArray;
    if ([array count] > 0)
    {
        resultMArray = [NSMutableArray arrayWithArray:array];
        [resultMArray removeObjectAtIndex:0];
        [resultMArray removeLastObject];
    }
    return resultMArray;
}

@end
