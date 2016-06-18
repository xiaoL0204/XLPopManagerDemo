//
//  XLPopManager.h
//  XLPopManagerDemo
//
//  Created by Xiaol on 16/6/18.
//  Copyright © 2016年 xiaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLPopManager : NSObject

//show   从外面坐标开始移动到全部显示
+(void)popViewFromVC:(UIViewController *)vc popView:(UIView *)popView;
//dismiss
+(void)dismiss;
+(void)dismissWithCompletion:(void(^)())completion;

@end
