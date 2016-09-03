//
//  popView.m
//  金泛斯测试
//
//  Created by 慧流 on 16/6/13.
//  Copyright © 2016年 范博. All rights reserved.
//

#import "popView.h"

@implementation popView

- (IBAction)btnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [self.delegate popView:self AndInt:sender.tag];
            break;
        case 1:

            [self.delegate popView:self AndInt:sender.tag];
            break;
        case 2:
            [self.delegate popView:self AndInt:sender.tag];
            break;
        case 3:
            [self.delegate popView:self AndInt:sender.tag];
            break;
        case 4:
            [self.delegate popView:self AndInt:sender.tag];
            break;
        case 5:
            [self.delegate popView:self AndInt:sender.tag];
            break;
        default:
            [self.delegate popView:self AndInt:sender.tag];
            break;
    }
}



@end
