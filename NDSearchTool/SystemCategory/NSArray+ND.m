//
//  NSArray+ND.m
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import "NSArray+ND.h"

@implementation NSArray (ND)

#pragma mark - Safe method

-(id)nd_objectWithIndex:(NSUInteger)index{
    if (index <self.count) {
        return self[index];
    }else{
        NSAssert(NO, @"index(%ld) is beyond the bounds of the array(%ld).", (long)index, (long)self.count);
        return nil;
    }
}

- (NSString*)nd_stringWithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return @"";
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


- (NSNumber*)nd_numberWithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
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

- (NSArray*)nd_arrayWithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
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


- (NSDictionary*)nd_dictionaryWithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
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

- (NSInteger)nd_integerWithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
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
- (NSUInteger)nd_unsignedIntegerWithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
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
- (BOOL)nd_boolWithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
    
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
- (int16_t)nd_int16WithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
    
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
- (int32_t)nd_int32WithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
    
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
- (int64_t)nd_int64WithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
    
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

- (char)nd_charWithIndex:(NSUInteger)index{
    
    id value = [self nd_objectWithIndex:index];
    
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

- (short)nd_shortWithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
    
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
- (float)nd_floatWithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
    
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
- (double)nd_doubleWithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
    
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

#pragma mark - Get CG object

- (CGFloat)nd_CGFloatWithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
    
    CGFloat f = [value doubleValue];
    
    return f;
}

- (CGPoint)nd_pointWithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
    
    CGPoint point = CGPointFromString(value);
    
    return point;
}
- (CGSize)nd_sizeWithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
    
    CGSize size = CGSizeFromString(value);
    
    return size;
}
- (CGRect)nd_rectWithIndex:(NSUInteger)index
{
    id value = [self nd_objectWithIndex:index];
    
    CGRect rect = CGRectFromString(value);
    
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

@end
