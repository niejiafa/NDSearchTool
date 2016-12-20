//
//  NSDate+ND.h
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ND)

#pragma mark - date formatter

- (NSString *)nd_stringWithDateFormatString:(NSString *)dateFormatString currentLocale:(BOOL)currentLocale;

- (NSString *)nd_currentLocaleStringWithDateFormatString:(NSString *)dateFormatString;

- (NSString *)nd_stringWithDateFormatString:(NSString *)dateFormatString;

@end
