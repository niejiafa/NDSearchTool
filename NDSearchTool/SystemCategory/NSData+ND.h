//
//  NSData+ND.h
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ND)

#pragma mark - String

- (NSString *)nd_UFT8String;

#pragma mark - JSON

- (NSDictionary *)nd_dictionaryWithJSON;
+ (NSDictionary *)nd_dictionaryWithJSONByFilePath:(NSString *)filePath;

#pragma mark - UIImage

- (NSString *)nd_contentTypeForImageData;

#pragma mark - MD5

- (NSString *)nd_md5Sting;
- (NSData *)nd_md5Data;

#pragma mark - Base64

- (NSString *)nd_base64EncodedString;
- (NSData *)nd_base64EncodedData;
- (NSString *)nd_base64DecodedString;
- (NSData *)nd_base64DecodedData;

#pragma mark - AES

- (NSData *)nd_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;
- (NSData *)nd_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

#pragma mark - 3DES

- (NSData *)nd_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;
- (NSData *)nd_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

@end
