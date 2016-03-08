//
//  NDCustomDemoViewController.m
//  NDSearchTool
//
//  Created by NDMAC on 16/3/8.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDCustomDemoViewController.h"

#import "NDCustomSearchViewController.h"

@interface NDCustomDemoViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL showSearchView;

@end

@implementation NDCustomDemoViewController

#pragma mark - life style

- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

#pragma mark - delegate

#pragma mark -- UITableViewDataSource UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @"Demo";
    return cell;
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.showSearchView) {
        CGRect tempRect = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 64);
        [UIView animateWithDuration:1.0 animations:^{
            self.tableView.frame = tempRect;
        } completion:^(BOOL finished) {
            self.showSearchView = NO;
            [self presentViewController:[[NDCustomSearchViewController alloc] init] animated:NO completion:nil];
        }];
    }
}

#pragma mark - observe

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"contentOffset"] && self.tableView.contentOffset.y <= -100)
    {
        self.showSearchView = YES;
    } else
    {
        self.showSearchView = NO;
    }
}

@end
