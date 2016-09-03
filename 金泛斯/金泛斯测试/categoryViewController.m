//
//  categoryViewController.m
//  金泛斯测试
//
//  Created by 慧流 on 16/6/12.
//  Copyright © 2016年 范博. All rights reserved.
//

#import "categoryViewController.h"
#import "detailViewController.h"
#import "MJExtension.h"
#import "btnView.h"
#import "popView.h"
#import "XMGShopCell.h"
#import "XMGShop.h"

@interface categoryViewController ()<btnViewDelegate,popViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation categoryViewController
{
    popView * popview;
    btnView *btview;
}
static NSString * const reuseIdentifier = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];


}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.shopArray = [NSMutableArray array];
    btview = [[btnView alloc]initWithFrame:CGRectMake(100,0,self.navigationController.view.bounds.size.width - 100,64)];
    [btview addBtnWithTitle:@"  筛选分类"];
//    [btview addBtnWithTitle:@"  GUCCI"];
//    [btview addBtnWithTitle:@"  秋季"];
//    [btview addBtnWithTitle:@"  均码"];
//    [btview addBtnWithTitle:@"  条纹"]; 
    self.view.backgroundColor = [UIColor grayColor];
    [self.navigationController.view addSubview:btview];
    btview.delegate = self;
    self.collectionView.backgroundColor = [UIColor grayColor];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:@selector(hiddenButton1)];
    self.navigationItem.backBarButtonItem = item;
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [self.flowLayout setItemSize:CGSizeMake(170, 210)];
    self.flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10,10);
    self.flowLayout.minimumLineSpacing = 15.0;//行间距(最小值)
    self.flowLayout.minimumInteritemSpacing = 10.0;//item间距(最小值)
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake( 0, 64,  self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:self.flowLayout];
    [self.collectionView setCollectionViewLayout:self.flowLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGShopCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

}

- (void) hiddenButton1{
    //[self.navigationController popViewControllerAnimated:NO];
}


-(void)tabbar:(UIButton *)btnview Andview:(popView *)popView{
    
    if (popview.hidden == NO){
        popview.hidden = YES;
    }
    
    switch (btnview.tag) {
        case 0:
            
            if (btnview.selected) {
                 [self presentSelectView:btnview.tag];
            }else{
                [self HiddenSelectView:btnview.tag];

            }
           

            break;
        case 1:
            if (btnview.selected) {
                [self presentSelectView:btnview.tag];
            }else{
                [self HiddenSelectView:btnview.tag];
            }
            break;
        case 2:
            if (btnview.selected) {
                [self presentSelectView:btnview.tag];
            }else{
                [self HiddenSelectView:btnview.tag];
                
            }
            break;
        case 3:
            if (btnview.selected) {
                [self presentSelectView:btnview.tag];
            }else{
                [self HiddenSelectView:btnview.tag];
                
            }
            break;
        case 4:
            if (btnview.selected) {
                [self presentSelectView:btnview.tag];
            }else{
                [self HiddenSelectView:btnview.tag];
                
            }
            break;
        default:
            if (btnview.selected) {
                [self presentSelectView:btnview.tag];
            }else{
                [self HiddenSelectView:btnview.tag];
                
            }
            break;
    }

}

- (void)presentSelectView:(int)tag{
    popview = [[NSBundle mainBundle] loadNibNamed:@"popView" owner:self options:nil].lastObject;
    popview.delegate = self;
    if (tag == 2) {
        popview.frame = CGRectMake(250 * tag - 30, 64, 200, 100);

    }else if (tag == 1){

        popview.frame = CGRectMake(250 * tag , 64, 200, 100);

    }else if (tag == 0){
        popview.frame = CGRectMake(250  , 64, 200, 100);
       //popview.frame = CGRectMake(70 , 64, 200, 100);
        [self.view addSubview:popview];
    }
    popview.hidden = YES;
   
    [UIView animateWithDuration:2.0 animations:^{
        popview.hidden = NO;
    }];

}

- (void)HiddenSelectView:(int)tag{
    switch (tag) {
        case 0:
        {
            [self.shopArray removeAllObjects];
            UIButton *btn =  (UIButton *)btview.subviews.firstObject;
            btn.titleLabel.text = @" 衬衣";

        }
            
            break;
        case 1:
        {
            UIButton *btn =  (UIButton *)btview.subviews.firstObject;
            btn.titleLabel.text = @" 短裤";

            
        }
            
            break;
        case 2:
        {
            UIButton *btn =  (UIButton *)btview.subviews.firstObject;
            btn.titleLabel.text = @" 牛仔";

            
        }
            
            break;
        case 3:
        {
            UIButton *btn =  (UIButton *)btview.subviews.firstObject;
            btn.titleLabel.text = @" 长裙";

        }
            
            break;
        case 4:
        {
            UIButton *btn =  (UIButton *)btview.subviews.firstObject;
            btn.titleLabel.text = @" 外套";

            
        }
            
            break;
        default:
        {
            UIButton *btn =  (UIButton *)btview.subviews.firstObject;
            btn.titleLabel.text = @" 帽子";
       
        }
            
            break;
    }

    [UIView animateWithDuration:2.0 animations:^{
        popview.hidden = YES;
    }];
}


-(void)popView:(popView *)popview1 AndInt:(int)count{
    switch (count) {
        case 0:
            {
                [self.shopArray removeAllObjects];
                UIButton *btn =  (UIButton *)btview.subviews.firstObject;
                btn.titleLabel.text = @" 衬衣";
                [btn setTitle:@" 衬衣" forState:UIControlStateSelected];
                [btn setTitle:@" 衬衣" forState:UIControlStateNormal];

                NSArray *shops = [XMGShop objectArrayWithFilename:@"chensha.plist"];
                [self.shopArray addObjectsFromArray:shops];
                [self.collectionView reloadData];
            }

            break;
        case 1:
            {
                UIButton *btn =  (UIButton *)btview.subviews.firstObject;
                btn.titleLabel.text = @" 短裙";
                [btn setTitle:@" 短裙" forState:UIControlStateSelected];
                [btn setTitle:@" 短裙" forState:UIControlStateNormal];
                [self.shopArray removeAllObjects];
                NSArray *shops = [XMGShop objectArrayWithFilename:@"duanqun.plist"];
                [self.shopArray addObjectsFromArray:shops];
                [self.collectionView reloadData];

            }

            break;
        case 2:
        {
            UIButton *btn =  (UIButton *)btview.subviews.firstObject;
            btn.titleLabel.text = @" 裤子";
            [btn setTitle:@" 裤子" forState:UIControlStateSelected];
            [btn setTitle:@" 裤子" forState:UIControlStateNormal];
            [self.shopArray removeAllObjects];
            NSArray *shops = [XMGShop objectArrayWithFilename:@"kuzi.plist"];
            [self.shopArray addObjectsFromArray:shops];
            [self.collectionView reloadData];

        }

            break;
        case 3:
        {
            UIButton *btn =  (UIButton *)btview.subviews.firstObject;
            btn.titleLabel.text = @" 连衣裙";
            [btn setTitle:@" 连衣裙" forState:UIControlStateSelected];
            [btn setTitle:@" 连衣裙" forState:UIControlStateNormal];
            [self.shopArray removeAllObjects];
            NSArray *shops = [XMGShop objectArrayWithFilename:@"lianyiqun.plist"];
            [self.shopArray addObjectsFromArray:shops];
            [self.collectionView reloadData];

        }

            break;
        case 4:
        {
            UIButton *btn =  (UIButton *)btview.subviews.firstObject;
            btn.titleLabel.text = @" 外套";
            [btn setTitle:@" 外套" forState:UIControlStateSelected];
            [btn setTitle:@" 外套" forState:UIControlStateNormal];
            [self.shopArray removeAllObjects];
            NSArray *shops = [XMGShop objectArrayWithFilename:@"shangyi.plist"];
            [self.shopArray addObjectsFromArray:shops];
            [self.collectionView reloadData];

        }

            break;
        default:
        {
            UIButton *btn =  (UIButton *)btview.subviews.firstObject;
            btn.titleLabel.text = @" 帽子";
            [btn setTitle:@" 帽子" forState:UIControlStateSelected];
            [btn setTitle:@" 帽子" forState:UIControlStateNormal];
            [self.shopArray removeAllObjects];
            NSArray *shops = [XMGShop objectArrayWithFilename:@"top.plist"];
            [self.shopArray addObjectsFromArray:shops];
            [self.collectionView reloadData];

        }

            break;
    }

}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shopArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMGShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    XMGShop *shop = self.shopArray[indexPath.row];
    cell.nameLabel.text = shop.h;
    cell.imageView.image = [UIImage imageNamed:shop.img];
    cell.price.text = shop.price;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    detailViewController *nextVc = [[detailViewController alloc]init];
    switch (indexPath.row) {
        case 0:
            nextVc.plist = self.shopArray;
            nextVc.count1 = indexPath.row;
            [self.navigationController pushViewController:nextVc animated:YES];
            break;
        case 1:
            nextVc.plist = self.shopArray;
            nextVc.count1 = indexPath.row;
            [self.navigationController pushViewController:nextVc animated:YES];
            break;
        case 2:
            nextVc.plist = self.shopArray;
            nextVc.count1 = indexPath.row;
            [self.navigationController pushViewController:nextVc animated:YES];
            break;
        case 3:
            nextVc.plist = self.shopArray;
            nextVc.count1 = indexPath.row;
            [self.navigationController pushViewController:nextVc animated:YES];
            break;
        case 4:
            nextVc.plist = self.shopArray;
            nextVc.count1 = indexPath.row;
            [self.navigationController pushViewController:nextVc animated:YES];
            break;
        case 5:
            nextVc.plist = self.shopArray;
            nextVc.count1 = indexPath.row;
            [self.navigationController pushViewController:nextVc animated:YES];
            break;
        case 6:
            nextVc.plist = self.shopArray;
            nextVc.count1 = indexPath.row;
            [self.navigationController pushViewController:nextVc animated:YES];
            break;
        case 7:
            nextVc.plist = self.shopArray;
            nextVc.count1 = indexPath.row;
            [self.navigationController pushViewController:nextVc animated:YES];
            break;
        default:
            nextVc.plist = self.shopArray;
            nextVc.count1 = indexPath.row;
            [self.navigationController pushViewController:nextVc animated:YES];
            break;
    }
    
}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    [btview removeFromSuperview];
}


@end
