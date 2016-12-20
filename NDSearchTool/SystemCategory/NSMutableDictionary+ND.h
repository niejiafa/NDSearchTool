//
//  NSMutableDictionary+ND.h
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableDictionary (ND)

#pragma mark - Safe method

-(void)nd_setObj:(id)i forKey:(NSString*)key;
-(void)nd_setString:(NSString*)i forKey:(NSString*)key;
-(void)nd_setBool:(BOOL)i forKey:(NSString*)key;
-(void)nd_setInt:(int)i forKey:(NSString*)key;
-(void)nd_setInteger:(NSInteger)i forKey:(NSString*)key;
-(void)nd_setUnsignedInteger:(NSUInteger)i forKey:(NSString*)key;
-(void)nd_setCGFloat:(CGFloat)f forKey:(NSString*)key;
-(void)nd_setChar:(char)c forKey:(NSString*)key;
-(void)nd_setFloat:(float)i forKey:(NSString*)key;
-(void)nd_setDouble:(double)i forKey:(NSString*)key;
-(void)nd_setLongLong:(long long)i forKey:(NSString*)key;
-(void)nd_setPoint:(CGPoint)o forKey:(NSString*)key;
-(void)nd_setSize:(CGSize)o forKey:(NSString*)key;
-(void)nd_setRect:(CGRect)o forKey:(NSString*)key;

@end
