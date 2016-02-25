//
//  NDSectionSearchViewController.m
//  NDSearchTool
//
//  Created by NDMAC on 16/2/24.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDSectionSearchViewController.h"

#import "NDSearchStockCompanyModel.h"
#import "NDSearchTool.h"

@interface NDSectionSearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *usualListDataSource;
@property (nonatomic, strong) NSMutableArray *traderListDataSource;
@property (nonatomic, strong) NSArray *usualListSearchDataSource;
@property (nonatomic, strong) NSArray *traderListSearchDataSource;
@property (nonatomic, strong) NSMutableArray *groupTitleArray;
@property (nonatomic, strong) NSMutableArray *searchGroupTitleArray;
@property (nonatomic, strong) NSMutableDictionary *filterDictionary;
@property (nonatomic, strong) NSMutableDictionary *searchFilterDictionary;

@end

@implementation NDSectionSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self nd_getIndexLetter];
    self.tableView.sectionIndexBackgroundColor=[UIColor clearColor];
    self.tableView.sectionIndexColor = [UIColor grayColor];
}
#pragma mark - delegate

#pragma mark - UITableViewDataSource UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.tableView == tableView) {
        return self.groupTitleArray.count;
    }
    return self.searchGroupTitleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableView == tableView) {
        return [self.filterDictionary[self.groupTitleArray[section]] count];
    }
    return [self.searchFilterDictionary[self.searchGroupTitleArray[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    NDSearchStockCompanyModel *model;
    if (self.tableView == tableView) {
        model = self.filterDictionary[self.groupTitleArray[indexPath.section]][indexPath.row];
    } else {
        model = self.searchFilterDictionary[self.searchGroupTitleArray[indexPath.section]][indexPath.row];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",model.name];
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.tableView == tableView) {
        return self.groupTitleArray;
    }
    return self.searchGroupTitleArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.tableView == tableView) {
        return self.groupTitleArray[section];
    }
    return self.searchGroupTitleArray[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSMutableArray *resultArray = (NSMutableArray *)[[NDSearchTool tool] searchWithAllFieldArray:@[@[@"name",@"cSpell"],@[@"name",@"cSpell"]]inputString:searchText inAllArray:@[self.usualListDataSource,self.traderListDataSource]];
    self.usualListSearchDataSource = resultArray[0];
    self.traderListSearchDataSource = resultArray[1];
    self.searchGroupTitleArray = [NSMutableArray array];
    self.searchFilterDictionary = [NSMutableDictionary dictionary];
    [self nd_getSearchIndexLetter];
    [self.searchDisplayController.searchResultsTableView reloadData];
}


#pragma mark - private

- (void)nd_getSearchIndexLetter
{
    for (NSString *aleph in [NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil]) {
        NSPredicate *alephPredicate = [NSPredicate predicateWithFormat:@"%K BEGINSWITH[cd] %@",@"cSpell",aleph];
        NSArray *tempArray = [self.traderListSearchDataSource filteredArrayUsingPredicate:alephPredicate];
        
        if (tempArray.count > 0) {
            self.searchFilterDictionary[aleph] = tempArray;
        }
    }
    
    [self.searchGroupTitleArray addObjectsFromArray:[self.searchFilterDictionary.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
    if (self.usualListSearchDataSource.count > 0) {
        [self.searchGroupTitleArray insertObject:@"常用" atIndex:0];
    }
    self.searchFilterDictionary[@"常用"] = self.usualListSearchDataSource;
}

- (void)nd_getIndexLetter
{
    for (NSString *aleph in [NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil]) {
        NSPredicate *alephPredicate = [NSPredicate predicateWithFormat:@"%K BEGINSWITH[cd] %@",@"cSpell",aleph];
        NSArray *tempArray = [self.traderListDataSource filteredArrayUsingPredicate:alephPredicate];
        
        if (tempArray.count > 0) {
            self.filterDictionary[aleph] = tempArray;
        }
    }
    
    [self.groupTitleArray addObjectsFromArray:[self.filterDictionary.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
    [self.groupTitleArray insertObject:@"常用" atIndex:0];
    self.filterDictionary[@"常用"] = self.usualListDataSource;
}

#pragma mark - getter and setter

- (NSMutableArray *)usualListDataSource
{
    if (_usualListDataSource) {
        return _usualListDataSource;
    }
    
    _usualListDataSource = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stockComany" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *fileArray = dict[@"usualList"];
    
    
    for (NSDictionary *dict in fileArray) {
        NDSearchStockCompanyModel *model = [[NDSearchStockCompanyModel alloc] init];
        model.name = dict[@"name"];
        model.cSpell = dict[@"cSpell"];
        [_usualListDataSource addObject:model];
    }
    
    return _usualListDataSource;
}

- (NSMutableArray *)traderListDataSource
{
    if (_traderListDataSource) {
        return _traderListDataSource;
    }
    
    _traderListDataSource = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stockComany" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *fileArray = dict[@"traderList"];
    
    
    for (NSDictionary *dict in fileArray) {
        NDSearchStockCompanyModel *model = [[NDSearchStockCompanyModel alloc] init];
        model.name = dict[@"name"];
        model.cSpell = dict[@"cSpell"];
        [_traderListDataSource addObject:model];
    }
    
    return _traderListDataSource;
}

- (NSMutableArray *)groupTitleArray
{
    if (_groupTitleArray) {
        return _groupTitleArray;
    }
    
    _groupTitleArray = [NSMutableArray array];
    
    return _groupTitleArray;
}

- (NSMutableDictionary *)filterDictionary
{
    if (_filterDictionary) {
        return _filterDictionary;
    }
    
    _filterDictionary = [NSMutableDictionary dictionary];
    
    return _filterDictionary;
}

@end
