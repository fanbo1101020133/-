//
//  itemsCell.h
//  testVideoAndPicture
//
//  Created by 慧流 on 16/5/29.
//  Copyright © 2016年 范博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface itemsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *isBaoyou;

@end
