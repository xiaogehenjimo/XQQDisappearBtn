//
//  mainViewController.m
//  XQQDisappearBtn
//
//  Created by XQQ on 16/10/12.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "mainViewController.h"

#define iphoneWidth  [UIScreen mainScreen].bounds.size.width
#define iphoneHeight [UIScreen mainScreen].bounds.size.height
@interface mainViewController ()

@property (nonatomic, assign) CGFloat  y;
/**装按钮的数组*/
@property(nonatomic, strong)  NSMutableArray  *  btnArr;
@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"测试";
    [self initUI];
}

- (void)initUI{
    NSArray * btnTitleArr = @[@"热点",@"国际",@"娱乐",@"消息",@"我的",@"热点",@"国际",@"娱乐",@"消息",@"我的"];
    for (NSInteger i = 0; i < btnTitleArr.count; i ++) {
        CGFloat buttonW = 60;
        CGFloat buttonH = 40;
        CGFloat buttonX = (iphoneWidth - buttonW) / 2;
        CGFloat buttonY = i * 60 + 100;
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [button setTitle:btnTitleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonDidPress:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor yellowColor];
        [self.btnArr addObject:button];
        [self.view addSubview:button];
    }
}
/**按钮点击*/
- (void)buttonDidPress:(UIButton*)button{
    NSInteger btnIndex = [self.btnArr indexOfObject:button];
    NSInteger count = self.btnArr.count;
    if (btnIndex == 0) {//点击第一个
        [button removeFromSuperview];
        [self.btnArr removeObject:button];
        for (UIButton * button in self.btnArr) {
            CGRect buttonFrame = button.frame;
            buttonFrame.origin.y -= 60;//这个60  按钮的高度 + 之间的间距
            [UIView animateWithDuration:.5f animations:^{
                 button.frame = buttonFrame;
            }];
        }
    }else if (btnIndex == count - 1){//点击最后一个
        [UIView animateWithDuration:.5f animations:^{
            [button removeFromSuperview];
            [self.btnArr removeObject:button];
        }];
    }else{//点击的是中间(第一个 ~ 最后一个之间)
        [button removeFromSuperview];
        [self.btnArr removeObject:button];
        for (NSInteger i = btnIndex; i < self.btnArr.count; i ++) {
            UIButton * button = nil;
            if (!(i  >= count)) {
               button = self.btnArr[i];
            }
            CGRect buttonFrame = button.frame;
            buttonFrame.origin.y -= 60;//这个60  按钮的高度 + 之间的间距
            [UIView animateWithDuration:.5f animations:^{
                 button.frame = buttonFrame;
            }];
        }
    }
}

- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = @[].mutableCopy;
    }
    return _btnArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
