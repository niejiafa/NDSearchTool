//
//  NSTimer+ND.h
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSTimer (ND)

#pragma mark - execute time

+ (double)nd_measureExecutionTime:(void (^)())block;

+ (void)nd_startTiming;
+ (double)nd_timeInterval;

@end
