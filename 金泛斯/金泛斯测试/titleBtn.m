//
//  titleBtn.m
//  金泛斯测试
//
//  Created by 慧流 on 16/6/12.
//  Copyright © 2016年 范博. All rights reserved.
//

#import "titleBtn.h"

@implementation titleBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down" ] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up" ] forState:UIControlStateSelected];
        [self sizeToFit];
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    CGFloat imageW = self.imageView.frame.size.width;
    self.imageView.frame = CGRectMake(0, 2, self.imageView.frame.size.width, self.imageView.frame.size.height);
    CGFloat titleW = imageW;
    self.titleLabel.frame = CGRectMake(titleW, 0, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
}
@end
