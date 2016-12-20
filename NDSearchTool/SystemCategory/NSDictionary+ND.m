//
//  NSDictionary+ND.m
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import "NSDictionary+ND.h"

@implementation NSDictionary (ND)

#pragma mark - Safe method

- (BOOL)nd_hasKey:(NSString *)key
{
    return [self objectForKey:key] != nil;
}

- (NSString*)nd_stringForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    NSAssert(NO, @"Value(%@) is not NSString class.", value);
    
    return nil;
}

- (NSNumber*)nd_numberForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    
    NSAssert(NO, @"Value(%@) is not NSNumber class.", value);
    
    return nil;
}

- (NSArray*)nd_arrayForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    
    NSAssert(NO, @"Value(%@) is not NSArray class.", value);
    
    return nil;
}

- (NSDictionary*)nd_dictionaryForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    
    NSAssert(NO, @"Value(%@) is not NSDictionary class.", value);
    
    return nil;
}

- (NSInteger)nd_integerForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to NSInteger.", value);
    
    return 0;
}
- (NSUInteger)nd_unsignedIntegerForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to NSUInteger.", value);
    
    return 0;
}
- (BOOL)nd_boolForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value boolValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to BOOL.", value);
    
    return NO;
}
- (int16_t)nd_int16ForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to int16_t.", value);
    
    return 0;
}
- (int32_t)nd_int32ForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to int32_t.", value);
    
    return 0;
}
- (int64_t)nd_int64ForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value longLongValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to int64_t.", value);
    
    return 0;
}
- (char)nd_charForKey:(id)key{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to char.", value);
    
    return 0;
}
- (short)nd_shortForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to short.", value);
    
    return 0;
}
- (float)nd_floatForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to float.", value);
    
    return 0;
}
- (double)nd_doubleForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to double.", value);
    
    return 0;
}
- (long long)nd_longLongForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value longLongValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to long long.", value);
    
    return 0;
}

- (unsigned long long)nd_unsignedLongLongForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to unsigned long long.", value);
    
    return 0;
}

#pragma mark - Get CG object

- (CGFloat)nd_CGFloatForKey:(id)key
{
    CGFloat f = [self[key] doubleValue];
    return f;
}

- (CGPoint)nd_pointForKey:(id)key
{
    CGPoint point = CGPointFromString(self[key]);
    return point;
}
- (CGSize)nd_sizeForKey:(id)key
{
    CGSize size = CGSizeFromString(self[key]);
    return size;
}
- (CGRect)nd_rectForKey:(id)key
{
    CGRect rect = CGRectFromString(self[key]);
    return rect;
}

#pragma mark - JSON

- (NSString *)nd_JSONString
{
    NSData *jsonData = [self nd_JSONSData];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (NSData *)nd_JSONSData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (error)
    {
        NSAssert(NO, @"From JSON object to data error: %@", error);
    }
    
    return jsonData;
}

#pragma mark - Merge

+ (NSDictionary *)nd_dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2 {
    NSMutableDictionary * result = [NSMutableDictionary dictionaryWithDictionary:dict1];
    [dict2 enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop)
    {
        if (![dict1 objectForKey:key])
        {
            if ([obj isKindOfClass:[NSDictionary class]])
            {
                NSDictionary * newVal = [[dict1 objectForKey: key] nd_dictionaryByMergingWith: (NSDictionary *) obj];
                [result setObject: newVal forKey: key];
            }
            else
            {
                [result setObject: obj forKey: key];
            }
        }
    }];
    return (NSDictionary *) [result mutableCopy];
}

- (NSDictionary *)nd_dictionaryByMergingWith:(NSDictionary *)dict {
    return [[self class] nd_dictionaryByMerging:self with: dict];
}

#pragma mark - Sort

- (NSDictionary *)nd_exchangeKeyAndValue
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop)
    {
        dic[obj] = key;
    }];
    
    return dic;
}

- (NSArray *)nd_valuesByKeys:(NSArray *)keys_
{
    NSMutableArray *valueList = [NSMutableArray array];
    [keys_ enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        id value = self[obj];
        if (value)
        {
            [valueList addObject:value];
        }
    }];
    
    return valueList;
}

- (NSArray *)nd_keyListBySortNSNumberLongKey:(BOOL)ascendingOrder_
{
    NSArray *sortKeys = [[self allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2)
                           {
                               if ([obj1 longValue] == [obj2 longValue])
                               {
                                   return (NSComparisonResult)NSOrderedSame;
                               }
                               
                               if ([obj1 longValue] > [obj2 longValue])
                               {
                                   if (ascendingOrder_)
                                   {
                                       return (NSComparisonResult)NSOrderedDescending;
                                   }
                                   else
                                   {
                                       return (NSComparisonResult)NSOrderedAscending;
                                   }
                               }
                               else
                               {
                                   if (ascendingOrder_)
                                   {
                                       return (NSComparisonResult)NSOrderedAscending;
                                   }
                                   else
                                   {
                                       return (NSComparisonResult)NSOrderedDescending;
                                   }
                               }
                           }];
    
    return sortKeys;
}

- (NSArray *)nd_keyListBySortNSStringLongKey:(BOOL)ascendingOrder_
{
    NSArray *sortKeys = [[self allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2)
                         {
                             if ([obj1 longLongValue] == [obj2 longLongValue])
                             {
                                 return (NSComparisonResult)NSOrderedSame;
                             }
                             
                             if ([obj1 longLongValue] > [obj2 longLongValue])
                             {
                                 if (ascendingOrder_)
                                 {
                                     return (NSComparisonResult)NSOrderedDescending;
                                 }
                                 else
                                 {
                                     return (NSComparisonResult)NSOrderedAscending;
                                 }
                             }
                             else
                             {
                                 if (ascendingOrder_)
                                 {
                                     return (NSComparisonResult)NSOrderedAscending;
                                 }
                                 else
                                 {
                                     return (NSComparisonResult)NSOrderedDescending;
                                 }
                             }
                         }];
    
    return sortKeys;
}

- (NSArray *)nd_valueListBySortNSNumberLongValue:(BOOL)ascendingOrder_
{
    NSArray *allValues = [self allValues];
    NSArray *sortValues = [allValues sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2)
    {
        if ([obj1 longValue] == [obj2 longValue])
        {
            return (NSComparisonResult)NSOrderedSame;
        }
        
        if ([obj1 longValue] > [obj2 longValue])
        {
            if (ascendingOrder_)
            {
                return (NSComparisonResult)NSOrderedDescending;
            }
            else
            {
                return (NSComparisonResult)NSOrderedAscending;
            }
        }
        else
        {
            if (ascendingOrder_)
            {
                return (NSComparisonResult)NSOrderedAscending;
            }
            else
            {
                return (NSComparisonResult)NSOrderedDescending;
            }
        }
    }];
    
    return sortValues;
}

- (NSArray *)nd_valueListBySortNSStringLongValue:(BOOL)ascendingOrder_
{
    NSArray *allValues = [self allValues];
    
    NSArray *sortValues = [allValues sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2)
    {
        if ([obj1 longLongValue] == [obj2 longLongValue])
        {
            return (NSComparisonResult)NSOrderedSame;
        }
        
        if ([obj1 longLongValue] > [obj2 longLongValue])
        {
            if (ascendingOrder_)
            {
                return (NSComparisonResult)NSOrderedDescending;
            }
            else
            {
                return (NSComparisonResult)NSOrderedAscending;
            }
        }
        else
        {
            if (ascendingOrder_)
            {
                return (NSComparisonResult)NSOrderedAscending;
            }
            else
            {
                return (NSComparisonResult)NSOrderedDescending;
            }
        }
    }];
    
    return sortValues;
}

@end
