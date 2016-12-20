//
//  NSMutableArray+ND.h
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableArray (ND)

#pragma mark - Safe method

-(void)nd_addObj:(id)i;
-(void)nd_addString:(NSString*)i;
-(void)nd_addBool:(BOOL)i;
-(void)nd_addInt:(int)i;
-(void)nd_addInteger:(NSInteger)i;
-(void)nd_addUnsignedInteger:(NSUInteger)i;
-(void)nd_addCGFloat:(CGFloat)f;
-(void)nd_addChar:(char)c;
-(void)nd_addFloat:(float)i;
-(void)nd_addPoint:(CGPoint)o;
-(void)nd_addSize:(CGSize)o;
-(void)nd_addRect:(CGRect)o;

@end
