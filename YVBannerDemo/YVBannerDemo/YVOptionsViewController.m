//
//  YVOptionsViewController.m
//  YVBannerDemo
//
//  Created by yi von on 2018/8/30.
//  Copyright © 2018年 YiVon. All rights reserved.
//

#import "YVOptionsViewController.h"

@interface YVOptionsViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YVOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = _dataSources[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_clickOptionBlock) {
        _clickOptionBlock(indexPath.row);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
