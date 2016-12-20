//
//  NSFileManager+ND.m
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import "NSFileManager+ND.h"

#import "NSDictionary+ND.h"

@implementation NSFileManager (ND)

#pragma mark - File exist

+ (BOOL)nd_isFileExistAtPath:(NSString*)fileFullPath isDirectory:(BOOL *)isDir
{
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath isDirectory:isDir];
    return isExist;
}

+ (BOOL)nd_isFileExistAtPath:(NSString*)fileFullPath
{
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
    return isExist;
}

#pragma mark - File path

+ (NSURL *)nd_URLForDirectory:(NSSearchPathDirectory)directory
{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)nd_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSString *)nd_documentsDirectory
{
    return [self nd_pathForDirectory:NSDocumentDirectory];
}

+ (NSString *)nd_libraryDirectory
{
    return [self nd_pathForDirectory:NSLibraryDirectory];
}

+ (NSString *)nd_cachesDirectory
{
    return [self nd_pathForDirectory:NSCachesDirectory];
}

+ (NSString *)nd_tempDirectory
{
    return NSTemporaryDirectory();
}

+ (BOOL)nd_createDirectoryAtPath:(NSString *)path_
{
    if ([self nd_isFileExistAtPath:path_])
    {
        return YES;
    }
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:path_ withIntermediateDirectories:YES attributes:nil error:&error];
    if (error)
    {
        NSAssert(@"Create directory failed, path: %@, error: %@", path_, error);
    }
    
    return success;
}

+ (NSString *)nd_filePathWithFileName:(NSString *)fileName_
{
    NSString *resource = fileName_;
    NSString *type= @"";
    
    NSRange range = [fileName_ rangeOfString:@"." options:NSBackwardsSearch];
    if (NSNotFound != range.location)
    {
        resource = [fileName_ substringToIndex:range.location];
        type = [fileName_ substringFromIndex:range.location + range.length];
    }
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:resource ofType:type];
    return filePath;
}

#pragma mark - Get file list

+ (NSArray *)nd_getFileNameOrPathList:(BOOL)needFullPath_
                          fromDirPath:(NSString *)dirPath_
                needCheckSubDirectory:(BOOL)needCheckSubDirectory_
                 fileNameCompareBlock:(BOOL (^)(NSString *fileName))fileNameCompareBlock_
{
    NSMutableArray *fileList = [NSMutableArray arrayWithCapacity:10];
    
    NSError *error;
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath_ error:&error];
    NSAssert(!error, @"%@", error);
    
    for (NSString *fileName in tmplist)
    {
        NSString *fullpath = [dirPath_ stringByAppendingPathComponent:fileName];
        BOOL isDir;
        BOOL fileExist = [self nd_isFileExistAtPath:fullpath isDirectory:&isDir];
        
        if (!fileExist)
        {
            continue;
        }
        
        if (isDir && needCheckSubDirectory_)
        {
            NSArray *subFileList = [self nd_getFileNameOrPathList:needFullPath_ fromDirPath:fullpath needCheckSubDirectory:needCheckSubDirectory_ fileNameCompareBlock:fileNameCompareBlock_];
            if ([subFileList count] > 0)
            {
                [fileList addObjectsFromArray:subFileList];
            }
            continue;
        }
        
        if (fileNameCompareBlock_)
        {
            if (!fileNameCompareBlock_(fileName))
            {
                continue;
            }
        }
        
        if (needFullPath_)
        {
            [fileList addObject:fullpath];
        }
        else
        {
            [fileList addObject:fileName];
        }
    }
    
    return fileList;
}

#pragma mark - Get file list by file type

+ (NSArray *)nd_getFileListOfType:(NSString *)type_ needFullPath:(BOOL)needFullPath_ fromDirPath:(NSString *)dirPath_
{
    return [self nd_getFileNameOrPathList:needFullPath_ fromDirPath:dirPath_ needCheckSubDirectory:NO fileNameCompareBlock:^BOOL(NSString *fileName)
            {
                BOOL success = [[fileName pathExtension] isEqualToString:type_];
                return success;
            }];
}

+ (NSArray *)nd_getFileNameListOfType:(NSString *)type_ fromDirPath:(NSString *)dirPath_
{
    return [self nd_getFileListOfType:type_ needFullPath:NO fromDirPath:dirPath_];
}

+ (NSArray *)nd_getFilePathListOfType:(NSString *)type_ fromDirPath:(NSString *)dirPath_
{
    return [self nd_getFileListOfType:type_ needFullPath:YES fromDirPath:dirPath_];
}

#pragma mark - Get file list by file name

+ (NSArray *)nd_getFileListOfPrefixName:(NSString *)prefixName_ needFullPath:(BOOL)needFullPath_ fromDirPath:(NSString *)dirPath_
{
    return [self nd_getFileNameOrPathList:needFullPath_ fromDirPath:dirPath_ needCheckSubDirectory:NO fileNameCompareBlock:^BOOL(NSString *fileName)
            {
                BOOL success = [fileName hasPrefix:prefixName_];
                return success;
            }];
}

+ (NSArray *)nd_getFileNameListOfPrefixName:(NSString *)prefixName_ fromDirPath:(NSString *)dirPath_
{
    return [self nd_getFileListOfPrefixName:prefixName_ needFullPath:NO fromDirPath:dirPath_];
}

+ (NSArray *)nd_getFilePathListOfPrefixName:(NSString *)prefixName_ fromDirPath:(NSString *)dirPath_
{
    return [self nd_getFileListOfPrefixName:prefixName_ needFullPath:YES fromDirPath:dirPath_];
}

#pragma mark - Remove expired file

+ (void)nd_removeExpiredCache:(NSString *)prefixName_ fromDirPath:(NSString *)dirPath_ secondOfExpiredTime:(NSInteger)secondOfExpiredTime_
{
    NSArray *filePathList = [self nd_getFilePathListOfPrefixName:prefixName_ fromDirPath:dirPath_];
    
    [self nd_removeExpiredCache:filePathList secondOfExpiredTime:secondOfExpiredTime_];
}

+ (void)nd_removeExpiredCacheWithType:(NSString *)type_ fromDirPath:(NSString *)dirPath_ secondOfExpiredTime:(NSInteger)secondOfExpiredTime_
{
    NSArray *filePathList = [self nd_getFilePathListOfType:type_ fromDirPath:dirPath_];
    
    [self nd_removeExpiredCache:filePathList secondOfExpiredTime:secondOfExpiredTime_];
}

+ (void)nd_removeExpiredCache:(NSArray *)filePathList_ secondOfExpiredTime:(NSInteger)secondOfExpiredTime_
{
    [filePathList_ enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         NSError *error;
         NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:obj error:&error];
         NSAssert(!error, @"%@", error);
         if (error)
         {
             return;
         }
         
         NSDate *fileModifyDate = [fileAttributes objectForKey:NSFileModificationDate];
         NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:fileModifyDate];
         if (fabs(timeInterval) > secondOfExpiredTime_)
         {
             [[NSFileManager defaultManager] removeItemAtPath:obj error:&error];
             NSAssert(!error, @"%@", error);
         }
     }];
}

#pragma mark - File size

+ (NSDictionary *)nd_fileSizeDictionaryFromDirPath:(NSString *)dirPath_ needCheckSubDirectory:(BOOL)needCheckSubDirectory_
{
    NSFileManager *localFileManager = [[NSFileManager alloc] init];
    
    NSURL *dirURL = [NSURL fileURLWithPath:dirPath_ isDirectory:YES];
    NSDirectoryEnumerator *dirEnumerator = [localFileManager enumeratorAtURL:dirURL
                                                  includingPropertiesForKeys:[NSArray arrayWithObjects:NSURLPathKey, NSURLIsDirectoryKey, NSURLFileSizeKey, nil]
                                                                     options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                errorHandler:nil];
    
    NSMutableDictionary *fileSizeDic = [NSMutableDictionary dictionary];
    
    for (NSURL *theURL in dirEnumerator)
    {
        NSString *filePath = @"";
        [theURL getResourceValue:&filePath forKey:NSURLPathKey error:NULL];
        
        NSNumber *isDir = nil;
        [theURL getResourceValue:&isDir forKey:NSURLIsDirectoryKey error:NULL];
        
        if (isDir && ![isDir boolValue])
        {
            NSNumber *fileSizeNumber = nil;
            [theURL getResourceValue:&fileSizeNumber forKey:NSURLFileSizeKey error:NULL];
            if (fileSizeNumber)
            {
                id key = fileSizeNumber;
                fileSizeDic[key] = filePath;
            }
        }
        else
        {
            if (needCheckSubDirectory_)
            {
                NSDictionary *subFileSizeDic = [NSFileManager nd_fileSizeDictionaryFromDirPath:filePath needCheckSubDirectory:needCheckSubDirectory_];
                [fileSizeDic addEntriesFromDictionary:subFileSizeDic];
            }
        }
    }
    
    return fileSizeDic;
}

+ (void)nd_printAllFileSizeToFilePath:(NSString *)filePath_
                     fromDirPathArray:(NSArray *)fromDirPathArray_
{
    FILE *file = fopen([filePath_ UTF8String], "w");
    if (NULL == file)
    {
        NSAssert(NO, @"Failed to open file: %@", filePath_);
        return;
    }
    
    NSDate* startDate = [NSDate date];
    
    NSMutableDictionary *allFileSizeDic = [NSMutableDictionary dictionary];
    
    [fromDirPathArray_ enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        NSDictionary *fileSizeDic = [NSFileManager nd_fileSizeDictionaryFromDirPath:obj needCheckSubDirectory:YES];
        [allFileSizeDic addEntriesFromDictionary:fileSizeDic];
    }];
    
    __block long totalSize = 0;
    NSMutableDictionary *directorySizeDic = [NSMutableDictionary dictionary];
    
    NSArray *sortKeys = [allFileSizeDic nd_keyListBySortNSNumberLongKey:YES];
    [sortKeys enumerateObjectsUsingBlock:^(NSNumber *sizeNumber, NSUInteger idx, BOOL * _Nonnull stop)
     {
         NSString *filePath = allFileSizeDic[sizeNumber];
         
         fprintf(file, "%ld\t\t%s\n", [sizeNumber longValue], [filePath UTF8String]);
         
         NSString *directory = [filePath stringByDeletingLastPathComponent];
         NSNumber *directorySizeNumber = directorySizeDic[directory];
         if (!directorySizeNumber)
         {
             directorySizeDic[directory] = @0;
         }
         
         long fileSize = [sizeNumber longValue];
         totalSize += fileSize;
         
         directorySizeDic[directory] = @([directorySizeNumber longValue] + fileSize);
     }];
    
    fprintf(file, "\n\n");
    
    NSDictionary *directoryNewDic = [directorySizeDic nd_exchangeKeyAndValue];
    NSArray *directorySortKeys = [directoryNewDic nd_keyListBySortNSNumberLongKey:YES];
    [directorySortKeys enumerateObjectsUsingBlock:^(NSNumber *sizeNumber, NSUInteger idx, BOOL * _Nonnull stop)
     {
         NSString *filePath = directoryNewDic[sizeNumber];
         
         fprintf(file, "%ld\t\t%s\n", [sizeNumber longValue], [filePath UTF8String]);
     }];
    
    fprintf(file, "\n\n");
    
    fprintf(file, "------- total size is %ld -------\n", totalSize);
    
    fprintf(file, "\n\n");
    
    NSDate *endDate = [NSDate date];
    NSTimeInterval totalTime = [endDate timeIntervalSinceDate:startDate];
    if (totalTime)
    {
        fprintf(file, "total time on listing all file size is %f\n", totalTime);
    }
    
    fclose(file);
}

@end
