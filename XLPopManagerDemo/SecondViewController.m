//
//  SecondViewController.m
//  XLPopManagerDemo
//
//  Created by Xiaol on 16/6/18.
//  Copyright © 2016年 xiaolin. All rights reserved.
//

#import "SecondViewController.h"
#import "XLRoomPopView.h"
#import "XLPopManager.h"
#import "UIView+Category.h"
#import "XLCustomModel.h"

@interface SecondViewController () <XLRoomPopViewDelegate>
@property (nonatomic,strong) XLRoomPopView *roomPopView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


static NSInteger count = 0;
- (IBAction)showPopView:(UIButton *)sender {
    XLCustomModel *model = [[XLCustomModel alloc]init];
    model.roomName = [NSString stringWithFormat:@"my custom name : %@",@(++count)];
    
    [self.roomPopView updateUIWithHotelRoomInfo:model];
    self.roomPopView.y = [[UIScreen mainScreen]bounds].size.height+40;
    [XLPopManager popViewFromVC:self.navigationController popView:self.roomPopView];
}


-(XLRoomPopView *)roomPopView{
    if (!_roomPopView) {
        _roomPopView = [[XLRoomPopView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height+40, [[UIScreen mainScreen]bounds].size.width, 250) customModel:nil delegate:self];
    }
    return _roomPopView;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
