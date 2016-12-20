//
//  NSArray+ND.h
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (ND)

#pragma mark - Safe method

-(id)nd_objectWithIndex:(NSUInteger)index;
- (NSString*)nd_stringWithIndex:(NSUInteger)index;
- (NSNumber*)nd_numberWithIndex:(NSUInteger)index;
- (NSArray*)nd_arrayWithIndex:(NSUInteger)index;
- (NSDictionary*)nd_dictionaryWithIndex:(NSUInteger)index;
- (NSInteger)nd_integerWithIndex:(NSUInteger)index;
- (NSUInteger)nd_unsignedIntegerWithIndex:(NSUInteger)index;
- (BOOL)nd_boolWithIndex:(NSUInteger)index;
- (int16_t)nd_int16WithIndex:(NSUInteger)index;
- (int32_t)nd_int32WithIndex:(NSUInteger)index;
- (int64_t)nd_int64WithIndex:(NSUInteger)index;
- (char)nd_charWithIndex:(NSUInteger)index;
- (short)nd_shortWithIndex:(NSUInteger)index;
- (float)nd_floatWithIndex:(NSUInteger)index;
- (double)nd_doubleWithIndex:(NSUInteger)index;

#pragma mark - Get CG object

- (CGFloat)nd_CGFloatWithIndex:(NSUInteger)index;
- (CGPoint)nd_pointWithIndex:(NSUInteger)index;
- (CGSize)nd_sizeWithIndex:(NSUInteger)index;
- (CGRect)nd_rectWithIndex:(NSUInteger)index;

#pragma mark - JSON

- (NSString *)nd_JSONString;
- (NSData *)nd_JSONSData;

@end
