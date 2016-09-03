//
//  btnView.m
//  金泛斯测试
//
//  Created by 慧流 on 16/6/12.
//  Copyright © 2016年 范博. All rights reserved.
//

#import "btnView.h"

@implementation btnView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;

}


#pragma mark 初始化按钮
-(void)addBtnWithTitle:(NSString *)title{
    titleBtn *categoryBtn = [[titleBtn alloc]init];
    [categoryBtn setTitle:title forState: UIControlStateNormal];
    [categoryBtn addTarget: self action:@selector(categoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    categoryBtn.tag = self.subviews.count;
        [self addSubview:categoryBtn];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    CGFloat btnW = self.bounds.size.width / count;
    CGFloat btnH = self.bounds.size.height;
    for (UIButton *btn in self.subviews) {
        //btn.frame = CGRectMake(15 + btnW * btn.tag, 30, btnW, btnH);
        btn.frame = CGRectMake(btnW/2 - 80, 30,100, btnH);
    }
}

-(void)categoryBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    [self.delegate tabbar:btn Andview:nil];
    

}
@end
