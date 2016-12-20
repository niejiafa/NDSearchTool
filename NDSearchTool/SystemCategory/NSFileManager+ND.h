//
//  NSFileManager+ND.h
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (ND)

#pragma mark - File exist

+ (BOOL)nd_isFileExistAtPath:(NSString*)fileFullPath isDirectory:(BOOL *)isDir;
+ (BOOL)nd_isFileExistAtPath:(NSString*)fileFullPath;

#pragma mark - File path

+ (NSURL *)nd_URLForDirectory:(NSSearchPathDirectory)directory;
+ (NSString *)nd_pathForDirectory:(NSSearchPathDirectory)directory;

+ (NSString *)nd_documentsDirectory;
+ (NSString *)nd_libraryDirectory;
+ (NSString *)nd_cachesDirectory;
+ (NSString *)nd_tempDirectory;

+ (BOOL)nd_createDirectoryAtPath:(NSString *)path;

+ (NSString *)nd_filePathWithFileName:(NSString *)fileName;

#pragma mark - Get file list

+ (NSArray *)nd_getFileNameOrPathList:(BOOL)needFullPath fromDirPath:(NSString *)dirPath needCheckSubDirectory:(BOOL)needCheckSubDirectory fileNameCompareBlock:(BOOL (^)(NSString *fileName))fileNameCompareBlock;

#pragma mark - Get file list by file type

+ (NSArray *)nd_getFileListOfType:(NSString *)type needFullPath:(BOOL)needFullPath fromDirPath:(NSString *)dirPath;
+ (NSArray *)nd_getFileNameListOfType:(NSString *)type fromDirPath:(NSString *)dirPath;
+ (NSArray *)nd_getFilePathListOfType:(NSString *)type fromDirPath:(NSString *)dirPath;

#pragma mark - Get file list by file name

+ (NSArray *)nd_getFileListOfPrefixName:(NSString *)prefixName needFullPath:(BOOL)needFullPath fromDirPath:(NSString *)dirPath;
+ (NSArray *)nd_getFileNameListOfPrefixName:(NSString *)prefixName fromDirPath:(NSString *)dirPath;
+ (NSArray *)nd_getFilePathListOfPrefixName:(NSString *)prefixName fromDirPath:(NSString *)dirPath;

#pragma mark - Remove expired file

+ (void)nd_removeExpiredCache:(NSString *)prefixName fromDirPath:(NSString *)dirPath secondOfExpiredTime:(NSInteger)secondOfExpiredTime;
+ (void)nd_removeExpiredCacheWithType:(NSString *)type fromDirPath:(NSString *)dirPath secondOfExpiredTime:(NSInteger)secondOfExpiredTime;

+ (void)nd_removeExpiredCache:(NSArray *)filePathList secondOfExpiredTime:(NSInteger)secondOfExpiredTime;

#pragma mark - File size

+ (NSDictionary *)nd_fileSizeDictionaryFromDirPath:(NSString *)dirPath needCheckSubDirectory:(BOOL)needCheckSubDirectory; // key: size; value: path

+ (void)nd_printAllFileSizeToFilePath:(NSString *)filePath fromDirPathArray:(NSArray *)fromDirPathArray;

@end
