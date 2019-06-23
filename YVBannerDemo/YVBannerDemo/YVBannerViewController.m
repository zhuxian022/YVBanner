//
//  ViewController.m
//  YVBannerDemo
//
//  Created by yi von on 2018/8/30.
//  Copyright © 2018年 YiVon. All rights reserved.
//

#import "YVBannerViewController.h"
#import "YVBanner.h"
#import "YVOptionsViewController.h"

#import "UIImageView+WebCache.h"

@interface YVBannerViewController ()

@property (nonatomic ,strong) YVBanner *bannerView;
@property (weak, nonatomic) IBOutlet UITextField *pageTextField;
@property (strong, nonatomic) IBOutlet UITextField *timeTF;

@property (nonatomic ,assign) NSInteger imageListIndex;
@property (nonatomic ,assign) BOOL isCustomAnimation;

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
        _bannerView = [[YVBanner alloc]initWithFrame:CGRectMake(0, Navigation_Height, IPHONE_WIDTH, 250-Navigation_Height)];
        
//        _bannerView.sepeWidth = 20;
        
        WS(weakSelf);
        _bannerView.clickBannerBlock = ^(NSInteger index) {
            [weakSelf.view endEditing:YES];
            NSLog(@"clickImageAtIndex:%ld",(long)index);
        };
        _bannerView.scrollBannerBlock = ^(NSInteger index) {
            weakSelf.pageTextField.text = [NSString stringWithFormat:@"%ld",(long)index+1];
        };
        
        [self setImageList:nil];
    }
    
    return _bannerView;
}

#pragma mark -Events
//图片列表
- (IBAction)setImageList:(UIButton *)sender {
    [self.view endEditing:YES];
    
    _imageListIndex = sender?sender.tag:0;
    NSArray *array = [self imagesWithIndex:_imageListIndex];
    
    [self.bannerView loadWithCount:array.count SetImages:^(iCarousel *carousel,UIView *view, NSInteger index) {
        UIImageView *imageView = (UIImageView *)view;
        
        if (!imageView) {
            if (self.isCustomAnimation) {
                imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(carousel.frame)/6*4, CGRectGetHeight(carousel.frame))];
            }
            else{
                imageView = [[UIImageView alloc]initWithFrame:carousel.bounds];
            }
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
        }
        
        id obj = array[index];
        if ([obj isKindOfClass:[UIImage class]]) {
            imageView.image = obj;
        }
        else if ([obj isKindOfClass:[NSString class]] && [obj hasPrefix:@"http"]){
            [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:nil];
        }
        else if ([obj isKindOfClass:[NSURL class]]){
            [imageView sd_setImageWithURL:obj placeholderImage:nil];
        }
        
        return imageView;
    }];
}

- (NSArray *)imagesWithIndex:(NSInteger)index{
    if (index) {
        return @[[UIImage imageNamed:@"timg-1.jpeg"],@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535622462426&di=51b760c72325eb162f5197149b65ebf9&imgtype=0&src=http%3A%2F%2Fpic.90sjimg.com%2Fback_pic%2F00%2F00%2F69%2F40%2F1d2b21ed851c406e42d9cc4e091bbb60.jpg",[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535622462426&di=2079a34ed7e0b32f04e98af84b8e7fa8&imgtype=0&src=http%3A%2F%2Fpic.90sjimg.com%2Fback_pic%2F00%2F00%2F69%2F40%2F9de73293f6a55dbcf52f3f36bfef3dd8.jpg"],[UIImage imageNamed:@"timg-2.jpeg"]];
    }
    else{
        return @[[UIImage imageNamed:@"timg-4.jpeg"],@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535622462425&di=868654d3db54f34b05d2c8e19a161201&imgtype=0&src=http%3A%2F%2Fpic.97uimg.com%2Fback_pic%2F20%2F15%2F11%2F13%2F38dd11cca0de8f1ac670dc82fca4e807.jpg",[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535622462425&di=f278a4bc6332f78d93dd7017b9bc231e&imgtype=0&src=http%3A%2F%2Fpic.90sjimg.com%2Fback_pic%2Fqk%2Fback_origin_pic%2F00%2F02%2F73%2F535c09a85c5deb1b3ffc9033981d55a1.jpg"]];
    }
}

//设置指示器类型
- (IBAction)setIndicatorType:(UIButton *)sender {
    [self.view endEditing:YES];
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
    [self.view endEditing:YES];
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

//跳转到某一页
- (IBAction)jumpToPage:(id)sender {
    [self.view endEditing:YES];
    NSInteger index = [_pageTextField.text integerValue]-1;
    if (index>=0 && index<[self imagesWithIndex:_imageListIndex].count) {
        _bannerView.currentIndex = index;
    }
}

//是否可循环
- (IBAction)setWrap:(UIButton *)sender {
    [self.view endEditing:YES];
    sender.selected = !sender.selected;
    _bannerView.wrap = sender.selected;
}

//设置自动滚动时间
- (IBAction)setAutoScrollTime:(id)sender {
    [self.view endEditing:YES];
    CGFloat time = [_timeTF.text floatValue];
    _bannerView.timeInverval = time;
}

//切换滚动样式
- (IBAction)changeScrollType:(UIButton *)sender {
    sender.selected = !sender.selected;
    _isCustomAnimation = sender.selected;
    if (sender.selected) {
        //自定义动画（Mac版QQ音乐样式）
        _bannerView.customAnimationBlock = ^CATransform3D(iCarousel *carousel, CGFloat offset, CATransform3D transform) {
            CGSize itemSize = CGSizeMake(CGRectGetWidth(carousel.frame)/6*4, CGRectGetHeight(carousel.frame));
            static CGFloat max_sacle = 1.0f;
            static CGFloat min_scale = 0.7f;
            if (offset <= 1 && offset >= -1) {
                float tempScale = offset < 0 ? 1+offset : 1-offset;
                float slope = (max_sacle - min_scale) / 1;
                
                CGFloat scale = min_scale + slope*tempScale;
                transform = CATransform3DScale(transform, scale, scale, 1);
            }else{
                transform = CATransform3DScale(transform, min_scale, min_scale, 1);
            }
            
            return CATransform3DTranslate(transform, offset * itemSize.width, 0.0, offset<0?offset:-offset);
        };
    }
    else{
        _bannerView.customAnimationBlock = nil;
    }
    
    sender.tag = _imageListIndex;
    [self setImageList:sender];
}

@end
