//
//  btnView.h
//  金泛斯测试
//
//  Created by 慧流 on 16/6/12.
//  Copyright © 2016年 范博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "titleBtn.h"
#import "btnView.h"
#import "popView.h"

@class btnView;
@protocol btnViewDelegate <NSObject>

-(void)tabbar:(UIButton *)btnview Andview:(popView *)popView;


@end
@interface btnView : UIView
-(void)addBtnWithTitle:(NSString *)title;
@property(nonatomic,weak)id<btnViewDelegate> delegate;

@end
