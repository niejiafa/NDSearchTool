//
//  NDDefaultFuzzySearchViewController.m
//  NDSearchTool
//
//  Created by NDMAC on 16/2/22.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDDefaultFuzzySearchViewController.h"
#import "NDSearchModel.h"
#import "NDSearchTool.h"
#import "UIImageView+LBBlurredImage.h"

@interface NDDefaultFuzzySearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>


@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;
@property (nonatomic, strong) UIImageView *fuzzyView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *searchDataSource;

@end

@implementation NDDefaultFuzzySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.fuzzyView addSubview:[[UIView alloc] init]];
    self.tableView.tableHeaderView = self.searchBar;
}

#pragma mark - delegate

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableView == tableView) {
        return self.dataSource.count;
    }
    
    return self.searchDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    NDSearchModel *model;
    if (self.tableView == tableView) {
        model = self.dataSource[indexPath.row];
    } else {
        model = self.searchDataSource[indexPath.row];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",model.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",model.code];
    
    return cell;
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.fuzzyView.hidden = NO;
    self.searchDisplayController.active = YES;
    
    if ([self.view.subviews[3] isKindOfClass:[UIView class]]) {
        [self.view.subviews[3] addSubview:self.fuzzyView];
    }
    
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    self.fuzzyView.hidden = YES;
    
    return YES;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchDataSource = (NSMutableArray *)[[NDSearchTool tool] searchWithFieldArray:@[@"name",@"pingyin",@"code"] inputString:searchText inArray:self.dataSource];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma  mark - UISearchDisplayDelegate

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    self.fuzzyView.hidden = YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView
{
    self.fuzzyView.hidden = NO;
}

#pragma mark - private


#pragma mark - getter and setter

- (NSMutableArray *)dataSource
{
    if (_dataSource) {
        return _dataSource;
    }
    
    _dataSource = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stockList" ofType:@"plist"];
    NSArray *fileArray = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *dict in fileArray) {
        NDSearchModel *model = [[NDSearchModel alloc] init];
        model.name = dict[@"name"];
        model.pingyin = dict[@"pingyin"];
        model.code = dict[@"code"];
        [_dataSource addObject:model];
    }
    
    return _dataSource;
}

- (UISearchBar *)searchBar
{
    if (_searchBar) {
        return _searchBar;
    }
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
    _searchBar.placeholder = @"您可以通过股票名称，简拼或代码进行查询";
    _searchBar.delegate = self;
    
    return _searchBar;
}

- (UISearchDisplayController *)searchDisplayController
{
    if (_searchDisplayController) {
        return _searchDisplayController;
    }
    
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    _searchDisplayController.delegate = self;
    _searchDisplayController.searchResultsTableView.dataSource = self;
    _searchDisplayController.searchResultsTableView.delegate = self;
    
    return _searchDisplayController;
}

- (UIImageView *)fuzzyView
{
    if (_fuzzyView) {
        return _fuzzyView;
    }
    
    _fuzzyView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 64)];
    
    [_fuzzyView setViewContext:self.tableView rectInView:self.tableView.frame blurRadius:10 completionBlock:nil];
    
    return _fuzzyView;
}

@end
