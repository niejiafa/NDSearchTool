//
//  NSData+ND.m
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import "NSData+ND.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (ND)

#pragma mark - String

-(NSString *)nd_UFT8String
{
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

#pragma mark - JSON

- (NSDictionary *)nd_dictionaryWithJSON
{
    NSError *error;
    id result = [NSJSONSerialization JSONObjectWithData:self
                                                options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                                  error:&error];
    
    if (error)
    {
        NSAssert(NO, @"From data to JSON object error: %@", error);
    }
    
    return result;
}

+ (NSDictionary *)nd_dictionaryWithJSONByFilePath:(NSString *)filePath
{
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return [data nd_dictionaryWithJSON];
}

#pragma mark - UIImage

- (NSString *)nd_contentTypeForImageData
{
    uint8_t c;
    [self getBytes:&c length:1];
    switch (c) {
        case 0xFF:
        return @"image/jpeg";
        case 0x89:
        return @"image/png";
        case 0x47:
        return @"image/gif";
        case 0x49:
        case 0x4D:
        return @"image/tiff";
        case 0x52:
        // R as RIFF for WEBP
        if ([self length] < 12) {
            return nil;
        }
        
        NSString *testString = [[NSString alloc] initWithData:[self subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
        if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
            return @"image/webp";
        }
        
        return nil;
    }
    return nil;
}

#pragma mark - MD5

- (NSString *)nd_md5Sting
{
    const char *cStr = [[self nd_UFT8String] UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    NSString *md5Sting = [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    return md5Sting;
}

- (NSData *)nd_md5Data
{
    NSString *md5Sting = [self nd_md5Sting];
    NSData *md5Data = [md5Sting dataUsingEncoding:NSUTF8StringEncoding];
    return md5Data;
}

#pragma mark - Base64

- (NSString *)nd_base64EncodedString
{
#warning - parameter right?
    NSString *base64EncodedString = [self base64EncodedStringWithOptions:0];
    return base64EncodedString;
}

- (NSData *)nd_base64EncodedData
{
    NSData *base64EncodedData = [self base64EncodedDataWithOptions:0];
    return base64EncodedData;
}

- (NSString *)nd_base64DecodedString
{
    NSString *base64DecodedString = [[self nd_base64DecodedData] nd_UFT8String];
    return base64DecodedString;
}

- (NSData *)nd_base64DecodedData
{
    NSData *base64DecodedData = [[NSData alloc] initWithBase64EncodedData:self options:0];
    return base64DecodedData;
}

#pragma mark - AES

- (NSData*)nd_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t dataMoved;
    NSMutableData *encryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];
    
    CCCryptorStatus status = CCCrypt(kCCEncrypt,                    // kCCEncrypt or kCCDecrypt
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding,         // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     iv.bytes,
                                     self.bytes,
                                     self.length,
                                     encryptedData.mutableBytes,    // encrypted data out
                                     encryptedData.length,
                                     &dataMoved);                   // total data moved
    
    if (status == kCCSuccess) {
        encryptedData.length = dataMoved;
        return encryptedData;
    }
    
    return nil;
    
}

- (NSData*)nd_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t dataMoved;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];
    
    CCCryptorStatus result = CCCrypt(kCCDecrypt,                    // kCCEncrypt or kCCDecrypt
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding,         // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     iv.bytes,
                                     self.bytes,
                                     self.length,
                                     decryptedData.mutableBytes,    // encrypted data out
                                     decryptedData.length,
                                     &dataMoved);                   // total data moved
    
    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }
    
    return nil;
    
}

#pragma mark - 3DES

- (NSData*)nd_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t dataMoved;
    NSMutableData *encryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];
    
    CCCryptorStatus result = CCCrypt(kCCEncrypt,                    // kCCEncrypt or kCCDecrypt
                                     kCCAlgorithm3DES,
                                     kCCOptionPKCS7Padding,         // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     iv.bytes,
                                     self.bytes,
                                     self.length,
                                     encryptedData.mutableBytes,    // encrypted data out
                                     encryptedData.length,
                                     &dataMoved);                   // total data moved
    
    if (result == kCCSuccess) {
        encryptedData.length = dataMoved;
        return encryptedData;
    }
    
    return nil;
    
}

- (NSData*)nd_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t dataMoved;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];
    
    CCCryptorStatus result = CCCrypt(kCCDecrypt,                    // kCCEncrypt or kCCDecrypt
                                     kCCAlgorithm3DES,
                                     kCCOptionPKCS7Padding,         // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     iv.bytes,
                                     self.bytes,
                                     self.length,
                                     decryptedData.mutableBytes,    // encrypted data out
                                     decryptedData.length,
                                     &dataMoved);                   // total data moved
    
    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }
    
    return nil;
    
}

@end
