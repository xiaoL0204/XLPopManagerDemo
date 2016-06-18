//
//  XLPopManager.m
//  XLPopManagerDemo
//
//  Created by Xiaol on 16/6/18.
//  Copyright © 2016年 xiaolin. All rights reserved.
//

#import "XLPopManager.h"
#import "UIView+Category.h"


@interface XLPopManager()
@property (nonatomic, strong, readonly) UIWindow *overlayWindow;

@property (nonatomic,strong) UIViewController *fromVC;
@property (nonatomic,strong) UIView *popView;
@property (nonatomic,strong) UIView *maskView;
@property (nonatomic,assign) CGRect popViewOrginFrame;
@end


@interface UIApplication (mainWindow)
- (UIWindow*)mainApplicationWindowIgnoringWindow:(UIWindow*)ignoringWindow;
@end


@implementation XLPopManager


@synthesize overlayWindow = _overlayWindow;

#pragma mark Class methods

+ (XLPopManager *)sharedInstance {
    static dispatch_once_t once;
    static XLPopManager *sharedInstance;
    dispatch_once(&once, ^ {
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+(void)popViewFromVC:(UIViewController *)vc popView:(UIView *)popView{
    [[self sharedInstance] showPopViewFromVC:vc popView:popView];
}

+(void)dismiss{
    [self dismissWithCompletion:nil];
}

+(void)dismissWithCompletion:(void(^)())completion{
    [[self sharedInstance] dismissFromScreenWithCompletion:^{
        if (completion) {
            completion();
        }
    }];
}


#pragma mark Instance methods

-(void)showPopViewFromVC:(UIViewController *)vc popView:(UIView *)popView{
    self.fromVC = vc;
    self.popView = popView;
    self.popViewOrginFrame = popView.frame;
    [self showOnScreen];
}




#pragma mark
- (void)showOnScreen{
    [self.overlayWindow setHidden:NO];
    [self.overlayWindow.rootViewController.view addSubview:self.fromVC.view];
    [self.overlayWindow addSubview:self.maskView];
    [self.overlayWindow addSubview:self.popView];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.fromVC.view.layer setTransform:[self firstTransform]];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.20 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.fromVC.view.layer setTransform:[self secondTransform]];
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.maskView setAlpha:0.5f];
        self.popView.y = self.overlayWindow.height-self.popView.height;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismissFromScreenWithCompletion:(void(^)())completion{
    [UIView animateWithDuration:0.20 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.fromVC.view.layer setTransform:[self firstTransform]];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.fromVC.view.layer setTransform:CATransform3DIdentity];
        } completion:^(BOOL finished) {
            [self.overlayWindow removeFromSuperview];
        }];
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.maskView setAlpha:0.f];
        self.popView.y = self.popViewOrginFrame.origin.y;
    } completion:^(BOOL finished) {
        [self.popView removeFromSuperview];
        if (completion) {
            completion();
        }
    }];
}


-(void)handleTapMaskView:(UITapGestureRecognizer *)tapGR{
    [self dismissFromScreenWithCompletion:nil];
}


- (CATransform3D)firstTransform{
    CATransform3D transform1 = CATransform3DIdentity;
    //近大远小
    transform1.m34 = 1.0/-1000;
    transform1 = CATransform3DScale(transform1, 0.95, 0.95, 1);
    transform1 = CATransform3DRotate(transform1, 10 * M_PI/180.0, 1, 0, 0);
    return transform1;
}

- (CATransform3D)secondTransform{
    CATransform3D transform2 = CATransform3DIdentity;
    transform2.m34 = [self firstTransform].m34;
    transform2 = CATransform3DScale(transform2, 0.9, 0.9, 1);
    transform2 = CATransform3DTranslate(transform2, 0, -10, 0);
    return transform2;
}





#pragma mark Lazy views

-(UIView *)maskView
{
    if (_maskView == nil) {
        _maskView = [[UIView alloc]initWithFrame:self.overlayWindow.bounds];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        _maskView.alpha = 0;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapMaskView:)];
        [_maskView addGestureRecognizer:tapGR];
    }
    return _maskView;
}

- (UIWindow *)overlayWindow
{
    if(_overlayWindow == nil) {
        _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayWindow.backgroundColor = [UIColor clearColor];
        _overlayWindow.windowLevel = UIWindowLevelNormal;
        _overlayWindow.rootViewController = [[UIViewController alloc] init];
        _overlayWindow.rootViewController.view.backgroundColor = [UIColor clearColor];
        [self updateWindowTransform];
    }
    return _overlayWindow;
}





#pragma mark Rotation

- (void)updateWindowTransform
{
    UIWindow *window = [[UIApplication sharedApplication]
                        mainApplicationWindowIgnoringWindow:self.overlayWindow];
    _overlayWindow.transform = window.transform;
    _overlayWindow.frame = window.frame;
}


@end




@implementation UIApplication (mainWindow)
// we don't want the keyWindow, since it could be our own window
- (UIWindow*)mainApplicationWindowIgnoringWindow:(UIWindow *)ignoringWindow {
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (!window.hidden && window != ignoringWindow) {
            return window;
        }
    }
    return nil;
}
@end

