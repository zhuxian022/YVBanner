# YVBanner

![quickLook](https://github.com/zhuxian022/YVBanner/blob/master/view.gif?raw=true)

![quickLook](https://github.com/zhuxian022/YVBanner/blob/master/customAnimation.gif?raw=true)

## Installation
#### 1.cocoapod 
```Object-C
pod 'YVBanner', '~> 1.4'
```

#### 2.add Files to your project

## Update 
* #### 2018.08.29 First version   v1.0
* #### 2018.08.31 bug fix v1.1 
* #### 2018.08.31 add AutoScroll v1.2
* #### 2018.09.03 support custom animation v1.3
* #### 2019.06.14 remove dependent on SDWebImage v1.4

## How To Use
#### import "YVBanner.h"
#### init YVBanner
```Object-C
_bannerView = [[YVBanner alloc]initWithFrame:CGRectMake(0, Navigation_Height, IPHONE_WIDTH, 300-Navigation_Height)];
[self.view addSubview:_bannerView];
```
#### set images
```Object-C
NSArray *array =@[[UIImage imageNamed:@"timg-1.jpeg"],@"https://timgsa.baidu.com/timg?image&src=http%bb60.jpg",[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image2f3f36bfef3dd8.jpg"],[UIImage imageNamed:@"timg-2.jpeg"]];
[_bannerView loadWithCount:array.count SetImages:^(UIImageView *imageView, NSInteger index) {
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
}];
```

#### set IndicatorType && IndicatorType
```Object-C
_bannerView.indicatorType = YVIndicatorTypePageControl;
_bannerView.indicatorPosition = YVIndicatorPositionRightDown;
```

#### set Wrap && CurrentIndex
```Object-C
_bannerView.wrap = YES;
_bannerView.currentIndex = 3;
```

#### set AutoScrollTime
```Object-C
_bannerView.timeInverval = 2.0f;
```

## Change Page && Click Page
```Object-C
_bannerView.clickBannerBlock = ^(NSInteger index) {
NSLog(@"clickImageAtIndex:%ld",(long)index);
};
_bannerView.scrollBannerBlock = ^(NSInteger index) {
NSLog(@"scrollToIndex:%ld",(long)index);
};    
```

## Custom Animation
#### 1.set bannerView's carousel dataSource & delegate
```Object-C
_bannerView.carousel.dataSource = self;
_bannerView.carousel.delegate = self;
_bannerView.carousel.type = iCarouselTypeCustom;
```
#### 2.implement bannerView's carousel dataSource & delegate 
[Please check iCarousel](https://github.com/nicklockwood/iCarousel) 

