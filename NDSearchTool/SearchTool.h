//
//  SearchTool.h
//  NDSearchTool
//
//  Created by NDMAC on 16/2/22.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchTool : NSObject

+ (SearchTool *)tool;

- (NSArray *)searchWithFieldArray:(NSArray *)fieldArray
                      inputString:(NSString *)inputString
                          inArray:(NSArray *)array;

@end
