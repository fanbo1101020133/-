//
//  detailViewController.m
//  金泛斯测试
//
//  Created by 慧流 on 16/6/13.
//  Copyright © 2016年 范博. All rights reserved.
//

#import "detailViewController.h"
#import "XMGShop.h"
#import "DetailCollectionViewCell.h"
static NSString *reuseIdentifier = @"reuseIdrntifier";

@interface detailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)NSTimer *hiddenTimer;                 //设置动画
@property(nonatomic,strong)UITapGestureRecognizer* tap;
@property(nonatomic) int timeStamp;

@end

@implementation detailViewController
{
    int pageCount;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNavBar)];
    self.hiddenTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTimeStamp) userInfo:nil repeats:true];
    [self.view addGestureRecognizer:_tap];
    pageCount = self.plist.count;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.title = @"金泛斯店铺";
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [self.flowLayout setItemSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height) collectionViewLayout:self.flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = true;
    self.collectionView.bounces = false;
    self.collectionView.showsHorizontalScrollIndicator = false;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DetailCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    int width = (int)self.view.bounds.size.width;
    self.collectionView.contentOffset  = CGPointMake( self.count1 * width, 0);
    [self.view addSubview:self.collectionView];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.plist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    XMGShop * model = self.plist[indexPath.item];
    cell.imageView.image = [UIImage imageNamed:model.img];
    NSLog(@"model.img %@",model.img);
    return cell;
}

- (void)viewDidAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:false];
}

- (void)changeTimeStamp {
    _timeStamp += 1;
    if (_timeStamp >= 5) {
        [UIView animateWithDuration:0.1 animations:^{
        } completion:^(BOOL finished) {
            [self.navigationController.navigationBar setHidden:true];
        }];
    }
}

-(void)showNavBar{
    _timeStamp = 0;
    [UIView animateWithDuration:0.1 animations:^{
        [self.navigationController.navigationBar setHidden:false];
        
    }];
}



@end
