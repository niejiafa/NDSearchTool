//
//  NSDate+ND.m
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import "NSDate+ND.h"

#import <objc/runtime.h>

static NSMutableDictionary *nd_g_s_dateformatDic;

@implementation NSDate (ND)

#pragma mark - date formatter

- (NSString *)nd_stringWithDateFormatString:(NSString *)dateFormatString_ currentLocale:(BOOL)currentLocale_
{
    if (!nd_g_s_dateformatDic)
    {
        nd_g_s_dateformatDic = [NSMutableDictionary dictionary];
    }
    
    NSDateFormatter *dateFormat = nd_g_s_dateformatDic[dateFormatString_];
    if (!dateFormat)
    {
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:dateFormatString_];
        if (currentLocale_)
        {
            dateFormat.locale = [NSLocale currentLocale];
        }
        
        nd_g_s_dateformatDic[dateFormatString_] = dateFormat;
    }
    
    NSString *dateString = [dateFormat stringFromDate:self];
    return dateString;
}

- (NSString *)nd_currentLocaleStringWithDateFormatString:(NSString *)dateFormatString_
{
    return [self nd_stringWithDateFormatString:dateFormatString_ currentLocale:YES];
}

- (NSString *)nd_stringWithDateFormatString:(NSString *)dateFormatString_
{
    return [self nd_stringWithDateFormatString:dateFormatString_ currentLocale:NO];
}

@end
