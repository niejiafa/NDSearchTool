//
//  NDSearchTool.m
//  NDSearchTool
//
//  Created by NDMAC on 16/2/22.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDSearchTool.h"

@implementation NDSearchTool

+ (NDSearchTool *)tool
{
    NDSearchTool *tool = [[NDSearchTool alloc] init];
    return tool;
}

- (NSArray *)searchWithFieldArray:(NSArray *)fieldArray
                      inputString:(NSString *)inputString
                          inArray:(NSArray *)array
{
    if (![array count] || ![fieldArray count]) {
        return nil;
    }
    
    NSPredicate *scopePredicate;
    NSMutableArray *backArray = [NSMutableArray array];
    
    for (NSString *fieldString in fieldArray) {
        NSArray *tempArray = [NSArray array];
        scopePredicate = [NSPredicate predicateWithFormat:@"SELF.%@ contains[c] %@", fieldString, inputString];
        tempArray = [array filteredArrayUsingPredicate:scopePredicate];
        for (NSObject *object in tempArray) {
            if (![backArray containsObject:object]) {
                [backArray addObject:object];
            }
        }
    }
    
    return backArray;
}

@end
