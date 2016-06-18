//
//  XLRoomPopView.h
//  XLPopManagerDemo
//
//  Created by Xiaol on 16/6/18.
//  Copyright © 2016年 xiaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLCustomModel;

@protocol XLRoomPopViewDelegate <NSObject>

@end

@interface XLRoomPopView : UIView

-(instancetype)initWithFrame:(CGRect)frame customModel:(XLCustomModel *)model delegate:(id<XLRoomPopViewDelegate>) delegate;
-(void)updateUIWithHotelRoomInfo:(XLCustomModel *)model;

@end
