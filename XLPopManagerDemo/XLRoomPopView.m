//
//  XLRoomPopView.m
//  XLPopManagerDemo
//
//  Created by Xiaol on 16/6/18.
//  Copyright © 2016年 xiaolin. All rights reserved.
//

#import "XLRoomPopView.h"
#import "XLCustomModel.h"

@interface XLRoomPopView()
@property (nonatomic,strong) UILabel *nameLabel;
@end

@implementation XLRoomPopView


-(instancetype)initWithFrame:(CGRect)frame customModel:(XLCustomModel *)model delegate:(id<XLRoomPopViewDelegate>) delegate{
    self = [super initWithFrame:frame];
    if (self) {
        //阴影
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, -5);
        self.layer.shadowOpacity = 0.6;
        self.backgroundColor = [UIColor orangeColor];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 200, 50)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.nameLabel];
        self.nameLabel.text = model.roomName;
    }
    return self;
}


-(void)updateUIWithHotelRoomInfo:(XLCustomModel *)model{
    self.nameLabel.text = model.roomName;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
