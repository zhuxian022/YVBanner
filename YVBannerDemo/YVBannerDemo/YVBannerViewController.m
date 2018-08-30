//
//  ViewController.m
//  YVBannerDemo
//
//  Created by ale tan on 2018/8/30.
//  Copyright © 2018年 YiVon. All rights reserved.
//

#import "YVBannerViewController.h"
#import "YVBanner.h"
#import "YVOptionsViewController.h"

@interface YVBannerViewController ()

@property (nonatomic ,strong) YVBanner *bannerView;

@end

@implementation YVBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YVBannerDemo";
    
    [self.view addSubview:self.bannerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -YVBanner-
- (YVBanner *)bannerView{
    if (!_bannerView) {
        _bannerView = [[YVBanner alloc]initWithFrame:CGRectMake(0, Navigation_Height, IPHONE_WIDTH, 300-Navigation_Height)];
        _bannerView.clickBannerBlock = ^(NSInteger index) {
            NSLog(@"clickImageAtIndex:%ld",(long)index);
        };
        [self setImageListFirst:nil];
        
        _bannerView.currentIndex = 2;
    }
    
    return _bannerView;
}

#pragma mark -Events
//图片列表1
- (IBAction)setImageListFirst:(id)sender {
    NSArray *array =@[[UIImage imageNamed:@"timg-1.jpeg"],@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535622462426&di=51b760c72325eb162f5197149b65ebf9&imgtype=0&src=http%3A%2F%2Fpic.90sjimg.com%2Fback_pic%2F00%2F00%2F69%2F40%2F1d2b21ed851c406e42d9cc4e091bbb60.jpg",[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535622462426&di=2079a34ed7e0b32f04e98af84b8e7fa8&imgtype=0&src=http%3A%2F%2Fpic.90sjimg.com%2Fback_pic%2F00%2F00%2F69%2F40%2F9de73293f6a55dbcf52f3f36bfef3dd8.jpg"],[UIImage imageNamed:@"timg-2.jpeg"]];
    self.bannerView.images = array;
}

//图片列表2
- (IBAction)setImageListSecond:(id)sender {
    NSArray *array =@[[UIImage imageNamed:@"timg-4.jpeg"],@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535622462425&di=868654d3db54f34b05d2c8e19a161201&imgtype=0&src=http%3A%2F%2Fpic.97uimg.com%2Fback_pic%2F20%2F15%2F11%2F13%2F38dd11cca0de8f1ac670dc82fca4e807.jpg",[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535622462425&di=f278a4bc6332f78d93dd7017b9bc231e&imgtype=0&src=http%3A%2F%2Fpic.90sjimg.com%2Fback_pic%2Fqk%2Fback_origin_pic%2F00%2F02%2F73%2F535c09a85c5deb1b3ffc9033981d55a1.jpg"]];
    self.bannerView.images = array;
}

//设置指示器类型
- (IBAction)setIndicatorType:(UIButton *)sender {
    NSArray *typeNames = @[@"YVIndicatorTypeNone",@"YVIndicatorTypeLabel",@"YVIndicatorTypePageControl"];
    
    YVOptionsViewController *optionsVC = [[YVOptionsViewController alloc]initWithNibName:@"YVOptionsViewController" bundle:nil];
    optionsVC.title = @"指示器类型";
    optionsVC.dataSources = typeNames;
    
    WS(weakSelf);
    optionsVC.clickOptionBlock = ^(NSInteger index) {
        [sender setTitle:typeNames[index] forState:UIControlStateNormal];
        weakSelf.bannerView.indicatorType = index;
    };
    [self.navigationController pushViewController:optionsVC animated:YES];
}

//设置指示器位置
- (IBAction)setIndicatorPosition:(UIButton *)sender {
    NSArray *positions = @[@"YVIndicatorPositionLeftUp",@"YVIndicatorPositionCenterUp",@"YVIndicatorPositionRightUp",@"YVIndicatorPositionCenter",@"YVIndicatorPositionLeftDown",@"YVIndicatorPositionCenterDown",@"YVIndicatorPositionRightDown"];
    
    YVOptionsViewController *optionsVC = [[YVOptionsViewController alloc]initWithNibName:@"YVOptionsViewController" bundle:nil];
    optionsVC.title = @"指示器位置";
    optionsVC.dataSources = positions;
    
    WS(weakSelf);
    optionsVC.clickOptionBlock = ^(NSInteger index) {
        [sender setTitle:positions[index] forState:UIControlStateNormal];
        weakSelf.bannerView.indicatorPosition = index;
    };
    [self.navigationController pushViewController:optionsVC animated:YES];
}

@end
