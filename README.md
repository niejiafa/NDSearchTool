# NDSearchTool
You can use a NDSearchTool to complete the search easily . It take a short time to complete the function

# Usage

* Use API

```objc
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

/**
*  分组搜索
*
*  @param allFieldArray  字段数组集合
*  @param inputString 输入文字
*  @param allArray  搜索数组集合
*
*  @return 搜索结果
*/
- (NSArray *)searchWithAllFieldArray:(NSArray *)allFieldArray
inputString:(NSString *)inputString
inAllArray:(NSArray *)allArray;

@end
```

* Use Example

```objc

[[NDSearchTool tool] searchWithFieldArray:@[@"name",@"pingyin",@"code"] inputString:searchText inArray:self.dataSource];

[[NDSearchTool tool] searchWithAllFieldArray:@[@[@"name",@"cSpell"],@[@"name",@"cSpell"]]inputString:searchText inAllArray:@[self.usualListDataSource,self.traderListDataSource]];

@end
```

* Time consuming

![image](https://github.com/indexjincieryi/NDSearchTool/blob/master/NDSearchToolUseTime.png)

* Demo show

![image](https://github.com/indexjincieryi/NDSearchTool/blob/master/NDSearchTool.gif)

# More Info

Have a question? Please [open an issue](https://github.com/indexjincieryi/NDSearchTool/issues)!
