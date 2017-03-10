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
@property (nonatomic, strong) NSMutableDictionary *filterDictionary;
@property (nonatomic, strong) NSMutableArray *searchDataSource;

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
    if (self.tableView == tableView)
    {
        return self.groupTitleArray.count;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableView == tableView)
    {
        return [self.filterDictionary[self.groupTitleArray[section]] count];
    }
    
    return [self.searchDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    NDSearchStockCompanyModel *model;
    if (self.tableView == tableView)
    {
        model = self.filterDictionary[self.groupTitleArray[indexPath.section]][indexPath.row];
    }
    else
    {
        model = self.searchDataSource[indexPath.row];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",model.name];
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.tableView == tableView)
    {
        return self.groupTitleArray;
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.tableView == tableView)
    {
        return self.groupTitleArray[section];
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.tableView == tableView)
    {
        return 30.f;
    }
    
    return 5.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.tableView == tableView)
    {
    }
    
    return 0.1f;
}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSMutableArray *resultArray = (NSMutableArray *)[[NDSearchTool tool] searchWithAllFieldArray:@[@[@"name",@"cSpell"],@[@"name",@"cSpell"]]
                                                                                     inputString:searchText
                                                                                      inAllArray:@[self.usualListDataSource,self.traderListDataSource]];
    self.usualListSearchDataSource = resultArray[0];
    self.traderListSearchDataSource = resultArray[1];
    self.searchDataSource = [NSMutableArray array];
    for (NDSearchStockCompanyModel *model in self.usualListSearchDataSource)
    {
        [self.searchDataSource addObject:model];
    }
    for (NDSearchStockCompanyModel *model in self.traderListSearchDataSource)
    {
        [self.searchDataSource addObject:model];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [self.searchDisplayController.searchResultsTableView reloadData];
#pragma clang diagnostic pop
}


#pragma mark - private

- (void)nd_getIndexLetter
{
    for (NSString *aleph in [NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil])
    {
        NSPredicate *alephPredicate = [NSPredicate predicateWithFormat:@"%K BEGINSWITH[cd] %@",@"cSpell",aleph];
        NSArray *tempArray = [self.traderListDataSource filteredArrayUsingPredicate:alephPredicate];
        
        if (tempArray.count > 0)
        {
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
    if (_usualListDataSource)
    {
        return _usualListDataSource;
    }
    
    _usualListDataSource = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stockComany" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *fileArray = dict[@"usualList"];
    
    
    for (NSDictionary *dict in fileArray)
    {
        NDSearchStockCompanyModel *model = [[NDSearchStockCompanyModel alloc] init];
        model.name = dict[@"name"];
        model.cSpell = dict[@"cSpell"];
        [_usualListDataSource addObject:model];
    }
    
    return _usualListDataSource;
}

- (NSMutableArray *)traderListDataSource
{
    if (_traderListDataSource)
    {
        return _traderListDataSource;
    }
    
    _traderListDataSource = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stockComany" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *fileArray = dict[@"traderList"];
    
    
    for (NSDictionary *dict in fileArray)
    {
        NDSearchStockCompanyModel *model = [[NDSearchStockCompanyModel alloc] init];
        model.name = dict[@"name"];
        model.cSpell = dict[@"cSpell"];
        [_traderListDataSource addObject:model];
    }
    
    return _traderListDataSource;
}

- (NSMutableArray *)groupTitleArray
{
    if (_groupTitleArray)
    {
        return _groupTitleArray;
    }
    
    _groupTitleArray = [NSMutableArray array];
    
    return _groupTitleArray;
}

- (NSMutableDictionary *)filterDictionary
{
    if (_filterDictionary)
    {
        return _filterDictionary;
    }
    
    _filterDictionary = [NSMutableDictionary dictionary];
    
    return _filterDictionary;
}

@end
