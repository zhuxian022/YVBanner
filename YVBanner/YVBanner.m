//
//  YVBanner.m
//  YVBannerDemo
//
//  Created by yi von on 2018/8/29.
//  Copyright © 2018年 YiVon. All rights reserved.
//

#import "YVBanner.h"

#import <SDWebImage/UIImageView+WebCache.h>

#define YVBannerHeight self.frame.size.height
#define YVBannerWidth self.frame.size.width

@interface YVBanner ()<iCarouselDataSource,iCarouselDelegate>

@property (nonatomic ,strong) NSTimer *timer;

@end

@implementation YVBanner

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _indicatorType = YVIndicatorTypeNone;
        _indicatorPosition = YVIndicatorPositionRightDown;
        _timeInverval = 0.f;
        
        _indicatorHorWidth = 20;
        _indicatorVerHeight = 0;
        
        [self addSubview:self.carousel];
        
        self.clipsToBounds = YES;
    }
    return self;
}

#pragma mark -Setter-
//更新frame
- (void)updateFrame:(CGRect)frame{
    self.frame = frame;
    
    _carousel.frame = self.bounds;
    [self setIndicatorFrame];
}

- (void)setTimeInverval:(NSTimeInterval)timeInverval{
    _timeInverval = timeInverval;
}

- (void)setWrap:(BOOL)wrap{
    _wrap = wrap;
    
    [_carousel reloadData];
}

- (void)setImages:(NSArray *)images{
    _images = images;
    
    [_carousel reloadData];
    if (_images.count-1) {
        _carousel.scrollEnabled = YES;
    }
    else{
        _carousel.scrollEnabled = NO;
    }
    
    [self setIndicatorFrame];
    
    [self startCountDown];
}

- (void)setIndicatorType:(YVIndicatorType)indicatorType{
    _indicatorType = indicatorType;
    
    switch (indicatorType) {
        case YVIndicatorTypeLabel:
            [self addSubview:self.indicatorLabel];
            break;
            
        case YVIndicatorTypePageControl:
            [self addSubview:self.pageControl];
            break;
            
        default:
            break;
    }
}

- (void)setIndicatorPosition:(YVIndicatorPosition)indicatorPosition{
    _indicatorPosition = indicatorPosition;
    
    [self setIndicatorFrame];
}

#pragma mark -UI-
- (iCarousel *)carousel{
    if (!_carousel) {
        _carousel = [[iCarousel alloc]initWithFrame:self.bounds];
        
        _carousel.dataSource = self;
        _carousel.delegate = self;
        
        _carousel.type = iCarouselTypeLinear;
        _carousel.vertical = NO;
        _carousel.pagingEnabled = YES;
        _carousel.bounceDistance = 0.f;
    }
    return _carousel;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl =  [[UIPageControl alloc] init];
        
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        
        _pageControl.currentPage = 0;
        _pageControl.hidesForSinglePage = YES;
        
        [_pageControl addTarget:self action:@selector(pageControlValueChange:) forControlEvents:UIControlEventValueChanged];
        
        [self setIndicatorFrame];
    }
    
    return _pageControl;
}

- (UILabel *)indicatorLabel{
    if (!_indicatorLabel) {
        _indicatorLabel = [[UILabel alloc]init];
        
        _indicatorLabel.textColor = [UIColor lightGrayColor];
        _indicatorLabel.font = [UIFont systemFontOfSize:12];
        
        [self setIndicatorFrame];
    }
    
    return _indicatorLabel;
}

//改变指示器位置
- (void)setIndicatorFrame{
    _indicatorLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)_currentIndex,(unsigned long)(_images?_images.count:0)];
    _pageControl.numberOfPages = _images?_images.count:0;
    
    switch (_indicatorPosition) {
        case YVIndicatorPositionLeftUp:
        {
            //label
            CGSize labelSize = CGSizeMake(80, 30);
            _indicatorLabel.frame = CGRectMake(_indicatorHorWidth, _indicatorVerHeight, labelSize.width, labelSize.height);
            _indicatorLabel.textAlignment = NSTextAlignmentLeft;
            
            //pageControl
            CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_images?_images.count:1];
            _pageControl.frame = CGRectMake(_indicatorHorWidth, _indicatorVerHeight, pageControlSize.width, pageControlSize.height);
        }
            break;
            
        case YVIndicatorPositionCenterUp:
        {
            //label
            CGSize labelSize = CGSizeMake(80, 30);
            _indicatorLabel.frame = CGRectMake((YVBannerWidth-labelSize.width)/2, _indicatorVerHeight, labelSize.width, labelSize.height);
            _indicatorLabel.textAlignment = NSTextAlignmentCenter;
            
            //pageControl
            CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_images?_images.count:1];
            _pageControl.frame = CGRectMake((YVBannerWidth-pageControlSize.width)/2, _indicatorVerHeight, pageControlSize.width, pageControlSize.height);
        }
            break;
            
        case YVIndicatorPositionRightUp:
        {
            //label
            CGSize labelSize = CGSizeMake(80, 30);
            _indicatorLabel.frame = CGRectMake(YVBannerWidth-labelSize.width-_indicatorHorWidth, _indicatorVerHeight, labelSize.width, labelSize.height);
            _indicatorLabel.textAlignment = NSTextAlignmentRight;
            
            //pageControl
            CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_images?_images.count:1];
            _pageControl.frame = CGRectMake(YVBannerWidth-pageControlSize.width-_indicatorHorWidth, _indicatorVerHeight, pageControlSize.width, pageControlSize.height);
        }
            break;
            
        case YVIndicatorPositionCenter:
        {
            //label
            CGSize labelSize = CGSizeMake(80, 30);
            _indicatorLabel.frame = CGRectMake((YVBannerWidth-labelSize.width)/2, (YVBannerHeight-labelSize.height)/2, labelSize.width, labelSize.height);
            _indicatorLabel.textAlignment = NSTextAlignmentCenter;
            
            //pageControl
            CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_images?_images.count:1];
            _pageControl.frame = CGRectMake((YVBannerWidth-pageControlSize.width)/2, (YVBannerHeight-pageControlSize.height)/2, pageControlSize.width, pageControlSize.height);
        }
            break;
            
        case YVIndicatorPositionLeftDown:
        {
            //label
            CGSize labelSize = CGSizeMake(80, 30);
            _indicatorLabel.frame = CGRectMake(_indicatorHorWidth, YVBannerHeight-labelSize.height-_indicatorVerHeight, labelSize.width, labelSize.height);
            _indicatorLabel.textAlignment = NSTextAlignmentLeft;
            
            //pageControl
            CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_images?_images.count:1];
            _pageControl.frame = CGRectMake(_indicatorHorWidth, YVBannerHeight-pageControlSize.height-_indicatorVerHeight, pageControlSize.width, pageControlSize.height);
        }
            break;
            
        case YVIndicatorPositionCenterDown:
        {
            //label
            CGSize labelSize = CGSizeMake(80, 30);
            _indicatorLabel.frame = CGRectMake((YVBannerWidth-labelSize.width)/2, YVBannerHeight-labelSize.height-_indicatorVerHeight, labelSize.width, labelSize.height);
            _indicatorLabel.textAlignment = NSTextAlignmentCenter;
            
            //pageControl
            CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_images?_images.count:1];
            _pageControl.frame = CGRectMake((YVBannerWidth-pageControlSize.width)/2, YVBannerHeight-pageControlSize.height-_indicatorVerHeight, pageControlSize.width, pageControlSize.height);
        }
            break;
            
        case YVIndicatorPositionRightDown:
        {
            //label
            CGSize labelSize = CGSizeMake(80, 30);
            _indicatorLabel.frame = CGRectMake(YVBannerWidth-labelSize.width-_indicatorHorWidth, YVBannerHeight-labelSize.height-_indicatorVerHeight, labelSize.width, labelSize.height);
            _indicatorLabel.textAlignment = NSTextAlignmentRight;
            
            //pageControl
            CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_images?_images.count:1];
            _pageControl.frame = CGRectMake(YVBannerWidth-pageControlSize.width-_indicatorHorWidth, YVBannerHeight-pageControlSize.height-_indicatorVerHeight, pageControlSize.width, pageControlSize.height);
        }
            break;
            
        default:
            break;
    }
}

//重新开始计时
- (void)startCountDown{
    [_timer invalidate];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInverval target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
}

- (void)scrollToNextPage{
    [_carousel scrollToItemAtIndex:_currentIndex++ animated:YES];
}

#pragma mark -UIPageControl-
- (void)pageControlValueChange:(UIPageControl *)pageControl {
    _currentIndex = pageControl.currentPage;
    [_carousel scrollToItemAtIndex:_currentIndex animated:YES];
}

#pragma mark -iCarousel-
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return _images.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    UIImageView *imageView = (UIImageView *)view;
    
    if (!imageView) {
        imageView = [[UIImageView alloc]initWithFrame:carousel.bounds];
    }
    
    id obj = _images[index];
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
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    switch (option) {
        case iCarouselOptionWrap:
        {
            if (_wrap && _images.count-1) {
                return 1;
            }
            else{
                return 0;
            }
        }
        default:
        {
            return value;
        }
    }
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    [_timer invalidate];
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    [self startCountDown];
}

- (void)carouselDidScroll:(iCarousel *)carousel{
    _currentIndex = carousel.currentItemIndex;
    if (_pageControl) {
        _pageControl.currentPage = _currentIndex;
    }
    if (_indicatorLabel) {
        _indicatorLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)_currentIndex,(unsigned long)(_images?_images.count:0)]
        ;
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if (_clickBannerBlock) {
        _clickBannerBlock(index);
    }
}

@end
