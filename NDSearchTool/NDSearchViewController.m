//
//  NDSearchViewController.m
//  NDSearchTool
//
//  Created by NDMAC on 16/2/22.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDSearchViewController.h"
#import "SearchModel.h"
#import "SearchTool.h"

@interface NDSearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *searchDataSource;

@end

@implementation NDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchDataSource = self.dataSource;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    SearchModel *model = self.searchDataSource[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",model.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",model.code];
    
    return cell;
}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchDataSource = (NSMutableArray *)[[SearchTool tool] searchWithFieldArray:@[@"name",@"pingyin",@"code"] inputString:searchText inArray:self.dataSource];
    [self.tableView reloadData];
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
        SearchModel *model = [[SearchModel alloc] init];
        model.name = dict[@"name"];
        model.pingyin = dict[@"pingyin"];
        model.code = dict[@"code"];
        [_dataSource addObject:model];
    }
    
    return _dataSource;
}

@end
