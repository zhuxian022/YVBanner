//
//  YVOptionsViewController.h
//  YVBannerDemo
//
//  Created by yi von on 2018/8/30.
//  Copyright © 2018年 YiVon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YVClickOption)(NSInteger index);

@interface YVOptionsViewController : UIViewController

@property (nonatomic ,strong) YVClickOption clickOptionBlock;

@property (nonatomic ,strong) NSArray *dataSources;

@end
