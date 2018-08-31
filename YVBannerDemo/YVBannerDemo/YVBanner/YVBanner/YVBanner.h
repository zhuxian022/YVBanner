//
//  YVBanner.h
//  YVBannerDemo
//
//  Created by yi von on 2018/8/29.
//  Copyright © 2018年 YiVon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iCarousel.h"

typedef enum : NSUInteger {
    YVIndicatorTypeNone = 0,
    YVIndicatorTypeLabel = 1,
    YVIndicatorTypePageControl = 2,
} YVIndicatorType;

typedef enum : NSUInteger {
    YVIndicatorPositionLeftUp = 0,
    YVIndicatorPositionCenterUp = 1,
    YVIndicatorPositionRightUp = 2,
    YVIndicatorPositionCenter = 3,
    YVIndicatorPositionLeftDown = 4,
    YVIndicatorPositionCenterDown = 5,
    YVIndicatorPositionRightDown = 6,
} YVIndicatorPosition;

typedef void(^YVClickBanner)(NSInteger index);
typedef void(^YVScrollBanner)(NSInteger index);

@interface YVBanner : UIView

#pragma UI控件
//图片滚动器
@property (nonatomic ,strong) iCarousel *carousel;

//指示器，只有indicatorType=IndicatorTypePageControl才显示
@property (nonatomic ,strong) UIPageControl *pageControl;

//页码label，只有indicatorType=IndicatorTypeLabel才显示
@property (nonatomic ,strong) UILabel *indicatorLabel;

#pragma 自定义属性
/*
 **自动轮播时间，0则不自动滚动
 */
@property (nonatomic ,assign) NSTimeInterval timeInverval;

/*
 **指示器类型,默认为空
 */
@property (nonatomic ,assign) YVIndicatorType indicatorType;

/*
 **指示器位置,默认右下角IndicatorPositionRightDown
 */
@property (nonatomic ,assign) YVIndicatorPosition indicatorPosition;

/*
 **指示器距离水平边距高度
 */
@property (nonatomic ,assign) CGFloat indicatorVerHeight;

/*
 **指示器距离垂直边距宽度
 */
@property (nonatomic ,assign) CGFloat indicatorHorWidth;

/*
 **是否循环,默认YES
 */
@property (nonatomic ,assign) BOOL wrap;

/*
 **当前index
 */
@property (nonatomic ,assign) NSInteger currentIndex;

/*
 **点击block
 */
@property (nonatomic ,strong) YVClickBanner clickBannerBlock;

/*
 **滚动block
 */
@property (nonatomic ,strong) YVScrollBanner scrollBannerBlock;

#pragma 数据
//数据
@property (nonatomic ,strong) NSArray *images;

@end
