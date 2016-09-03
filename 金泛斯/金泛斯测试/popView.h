//
//  popView.h
//  金泛斯测试
//
//  Created by 慧流 on 16/6/13.
//  Copyright © 2016年 范博. All rights reserved.
//

#import <UIKit/UIKit.h>

@class popView;

@protocol popViewDelegate <NSObject>
-(void)popView:(popView *)popview1 AndInt:(int)count;
@end

@interface popView : UIView
@property(nonatomic, weak)NSArray *array;
@property(nonatomic, weak)id<popViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *fistBtn;
@property (weak, nonatomic) IBOutlet UIButton *second;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthBtn;
@property (weak, nonatomic) IBOutlet UIButton *firthBtn;
@property (weak, nonatomic) IBOutlet UIButton *sixthBtn;

@end
