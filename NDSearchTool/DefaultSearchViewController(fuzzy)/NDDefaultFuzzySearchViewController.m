//
//  NDDefaultFuzzySearchViewController.m
//  NDSearchTool
//
//  Created by NDMAC on 16/2/22.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDDefaultFuzzySearchViewController.h"

#import "NDSearchStockModel.h"
#import "NDSearchTool.h"
#import "UIImageView+LBBlurredImage.h"

@interface NDDefaultFuzzySearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;
@property (nonatomic, strong) UIImageView *fuzzyView;
@property (nonatomic, strong) UIView *adviceView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *searchDataSource;

@end

@implementation NDDefaultFuzzySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.fuzzyView addSubview:self.adviceView];
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
    
    NDSearchStockModel *model;
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
    if ([searchBar.text length]) {
        self.fuzzyView.hidden = YES;
    } else {
        self.fuzzyView.hidden = NO;
    }
    self.searchDisplayController.active = YES;
    
    if ([self.view.subviews[3] isKindOfClass:[UIView class]]) {
        [self.view.subviews[3] addSubview:self.fuzzyView];
    }
    
    return YES;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchBar.text length]) {
        self.fuzzyView.hidden = YES;
    } else {
        self.fuzzyView.hidden = NO;
    }

    self.searchDataSource = (NSMutableArray *)[[NDSearchTool tool] searchWithFieldArray:@[@"name",@"pingyin",@"code"] inputString:searchText inArray:self.dataSource];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

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
        NDSearchStockModel *model = [[NDSearchStockModel alloc] init];
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
    _searchBar.delegate = self;
    
    return _searchBar;
}

- (UISearchDisplayController *)searchDisplayController
{
    if (_searchDisplayController) {
        return _searchDisplayController;
    }
    
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
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

- (UIView *)adviceView
{
    if (_adviceView) {
        return _adviceView;
    }
    
    _adviceView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, CGRectGetWidth([UIScreen mainScreen].bounds), 200)];
    _adviceView.backgroundColor = [UIColor clearColor];
    
    NSInteger space = (CGRectGetWidth([UIScreen mainScreen].bounds) - 3 * 60) / 4;
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(space + i * (60 + space), 0, 60, 60)];
        [_adviceView addSubview:imageView];
        imageView.backgroundColor = [UIColor redColor];
    }
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60 + 30, CGRectGetWidth([UIScreen mainScreen].bounds), 30)];
    textLabel.text = @"您可以通过股票名称，简拼或代码进行查询";
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.textColor = [UIColor grayColor];
    [_adviceView addSubview:textLabel];
    
    return _adviceView;
}

@end
