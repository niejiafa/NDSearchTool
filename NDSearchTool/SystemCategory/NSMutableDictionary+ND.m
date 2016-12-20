//
//  NSMutableDictionary+ND.m
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import "NSMutableDictionary+ND.h"

@implementation NSMutableDictionary (ND)

-(void)nd_setObj:(id)i forKey:(NSString*)key{
    if (i!=nil) {
        self[key] = i;
    }
}
-(void)nd_setString:(NSString*)i forKey:(NSString*)key;
{
    [self setValue:i forKey:key];
}
-(void)nd_setBool:(BOOL)i forKey:(NSString *)key
{
    self[key] = @(i);
}
-(void)nd_setInt:(int)i forKey:(NSString *)key
{
    self[key] = @(i);
}
-(void)nd_setInteger:(NSInteger)i forKey:(NSString *)key
{
    self[key] = @(i);
}
-(void)nd_setUnsignedInteger:(NSUInteger)i forKey:(NSString *)key
{
    self[key] = @(i);
}
-(void)nd_setCGFloat:(CGFloat)f forKey:(NSString *)key
{
    self[key] = @(f);
}
-(void)nd_setChar:(char)c forKey:(NSString *)key
{
    self[key] = @(c);
}
-(void)nd_setFloat:(float)i forKey:(NSString *)key
{
    self[key] = @(i);
}
-(void)nd_setDouble:(double)i forKey:(NSString*)key{
    self[key] = @(i);
}
-(void)nd_setLongLong:(long long)i forKey:(NSString*)key{
    self[key] = @(i);
}
-(void)nd_setPoint:(CGPoint)o forKey:(NSString *)key
{
    self[key] = NSStringFromCGPoint(o);
}
-(void)nd_setSize:(CGSize)o forKey:(NSString *)key
{
    self[key] = NSStringFromCGSize(o);
}
-(void)nd_setRect:(CGRect)o forKey:(NSString *)key
{
    self[key] = NSStringFromCGRect(o);
}

@end
