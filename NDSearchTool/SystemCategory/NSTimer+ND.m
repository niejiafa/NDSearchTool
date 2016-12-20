//
//  NSTimer+ND.m
//  JJObjCTool
//
//  Created by NDMAC on 15/12/29.
//  Copyright (c) 2015 NDEducation. All rights reserved.
//

#import "NSTimer+ND.h"

@implementation NSTimer (ND)

#pragma mark - execute time

+ (double)nd_measureExecutionTime:(void (^)())block
{
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    block();
    
    double executionTime = CFAbsoluteTimeGetCurrent() - startTime;
    return executionTime;
}

static CFAbsoluteTime g_s_nd_startTime;

+ (void)nd_startTiming
{
    g_s_nd_startTime = CFAbsoluteTimeGetCurrent();
}

+ (double)nd_timeInterval
{
    double startTime = g_s_nd_startTime;
    g_s_nd_startTime = CFAbsoluteTimeGetCurrent();
    double timeInterval = g_s_nd_startTime - startTime;
    
    return timeInterval;
}

@end
