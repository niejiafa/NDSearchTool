//
//  NSDictionary+ND.h
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (ND)

#pragma mark - Safe method

- (BOOL)nd_hasKey:(NSString *)key;
- (NSString*)nd_stringForKey:(id)key;
- (NSNumber*)nd_numberForKey:(id)key;
- (NSArray*)nd_arrayForKey:(id)key;
- (NSDictionary*)nd_dictionaryForKey:(id)key;
- (NSInteger)nd_integerForKey:(id)key;
- (NSUInteger)nd_unsignedIntegerForKey:(id)key;
- (BOOL)nd_boolForKey:(id)key;
- (int16_t)nd_int16ForKey:(id)key;
- (int32_t)nd_int32ForKey:(id)key;
- (int64_t)nd_int64ForKey:(id)key;
- (char)nd_charForKey:(id)key;
- (short)nd_shortForKey:(id)key;
- (float)nd_floatForKey:(id)key;
- (double)nd_doubleForKey:(id)key;
- (long long)nd_longLongForKey:(id)key;
- (unsigned long long)nd_unsignedLongLongForKey:(id)key;

#pragma mark - Get CG object

- (CGFloat)nd_CGFloatForKey:(id)key;
- (CGPoint)nd_pointForKey:(id)key;
- (CGSize)nd_sizeForKey:(id)key;
- (CGRect)nd_rectForKey:(id)key;

#pragma mark - JSON

- (NSString *)nd_JSONString;
- (NSData *)nd_JSONSData;

#pragma mark - Merge

+ (NSDictionary *)nd_dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;
- (NSDictionary *)nd_dictionaryByMergingWith:(NSDictionary *)dict;

#pragma mark - Sort

- (NSDictionary *)nd_exchangeKeyAndValue;

- (NSArray *)nd_valuesByKeys:(NSArray *)keys;

- (NSArray *)nd_keyListBySortNSNumberLongKey:(BOOL)ascendingOrder;
- (NSArray *)nd_keyListBySortNSStringLongKey:(BOOL)ascendingOrder;

- (NSArray *)nd_valueListBySortNSNumberLongValue:(BOOL)ascendingOrder;
- (NSArray *)nd_valueListBySortNSStringLongValue:(BOOL)ascendingOrder;

@end
