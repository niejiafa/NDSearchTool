//
//  NDSearchToolTests.m
//  NDSearchToolTests
//
//  Created by NDMAC on 16/2/22.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NDSearchStockModel.h"
#import "NDSearchTool.h"

@interface NDSearchToolTests : XCTestCase

@property (nonatomic, strong) NSMutableArray *allFieldArray;

@end

@implementation NDSearchToolTests

- (void)setUp {
    [super setUp];
    self.allFieldArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 10000; i++) {
        NDSearchStockModel *fieldModel = [[NDSearchStockModel alloc] init];
        fieldModel.pingyin = [NSString stringWithFormat:@"FieldModelPingYin%ld",i];
        fieldModel.code = [NSString stringWithFormat:@"FieldModelStockCode%ld",i];
        [self.allFieldArray addObject:fieldModel];
    }
}

- (void)tearDown {
    self.allFieldArray = nil;
    [super tearDown];
}

- (void)testSearchTime {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [[NDSearchTool tool] searchWithFieldArray:@[@"pingyin",@"code"] inputString:@"FieldModelPingYin5000" inArray:self.allFieldArray];
    }];
}

@end
