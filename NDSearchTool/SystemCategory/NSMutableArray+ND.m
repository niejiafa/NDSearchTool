//
//  NSMutableArray+ND.m
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import "NSMutableArray+ND.h"

@implementation NSMutableArray (ND)

#pragma mark - Safe method

-(void)nd_addObj:(id)i{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)nd_addString:(NSString*)i
{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)nd_addBool:(BOOL)i
{
    [self addObject:@(i)];
}
-(void)nd_addInt:(int)i
{
    [self addObject:@(i)];
}
-(void)nd_addInteger:(NSInteger)i
{
    [self addObject:@(i)];
}
-(void)nd_addUnsignedInteger:(NSUInteger)i
{
    [self addObject:@(i)];
}
-(void)nd_addCGFloat:(CGFloat)f
{
    [self addObject:@(f)];
}
-(void)nd_addChar:(char)c
{
    [self addObject:@(c)];
}
-(void)nd_addFloat:(float)i
{
    [self addObject:@(i)];
}
-(void)nd_addPoint:(CGPoint)o
{
    [self addObject:NSStringFromCGPoint(o)];
}
-(void)nd_addSize:(CGSize)o
{
    [self addObject:NSStringFromCGSize(o)];
}
-(void)nd_addRect:(CGRect)o
{
    [self addObject:NSStringFromCGRect(o)];
}

@end
