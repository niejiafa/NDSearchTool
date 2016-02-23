//
//  NDSearchTool.h
//  NDSearchTool
//
//  Created by NDMAC on 16/2/22.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDSearchTool : NSObject

/**
 *  创建实例对象
 *
 *  @return 搜索对象
 */
+ (NDSearchTool *)tool;

/**
 *  默认搜索
 *
 *  @param fieldArray  搜索字段数组
 *  @param inputString 输入文字
 *  @param array       搜索数据源
 *
 *  @return 搜索结果
 */
- (NSArray *)searchWithFieldArray:(NSArray *)fieldArray
                      inputString:(NSString *)inputString
                          inArray:(NSArray *)array;

@end
