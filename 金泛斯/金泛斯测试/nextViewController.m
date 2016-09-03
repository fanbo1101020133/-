//
//  nextViewController.m
//  金泛斯测试
//
//  Created by 慧流 on 16/6/12.
//  Copyright © 2016年 范博. All rights reserved.
//

#import "nextViewController.h"
#import "MJExtension.h"
#import "categoryViewController.h"
#import "XMGPhotoCell.h"
#import "searchTeams.h"
#import "XMGShop.h"
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H  [UIScreen mainScreen].bounds.size.height
@interface nextViewController ()<UIScrollViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UISearchBarDelegate>

{
    BOOL *flag;
    UIView *  view;
    UISearchBar *customSearchBar;
    NSArray *shops;
}
@property (nonatomic, weak) UIScrollView *scrollview;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)NSTimer *joinTimer;
@property (weak, nonatomic)  UIPageControl *pc;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation nextViewController
static NSString * const reuseIdentifier = @"shop";
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    flag = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@" " style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = cancelButton;
    CGRect mainViewBounds = self.navigationController.view.bounds;
    customSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,CGRectGetMinY(mainViewBounds) + 20,self.navigationController.view.bounds.size.width,40)];
    customSearchBar.delegate = self;
    customSearchBar.showsCancelButton = YES;
    customSearchBar.layer.cornerRadius = 1;
    [self.navigationController.view addSubview:customSearchBar];
    customSearchBar.layer.cornerRadius = 5;
    customSearchBar.layer.masksToBounds = YES;
    customSearchBar.showsCancelButton = NO;
    [self.view addSubview:[self creatscrllview]];
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [self.flowLayout setItemSize:CGSizeMake(200, 200)];
    self.flowLayout.sectionInset = UIEdgeInsetsMake(10, 35,5,35);
    self.flowLayout.minimumLineSpacing = 20.0;//行间距(最小值)
    self.flowLayout.minimumInteritemSpacing = 10.0;//item间距(最小值)
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,300 + 20,self.view.bounds.size.width,self.view.bounds.size.height - 340) collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView setCollectionViewLayout:self.flowLayout];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.joinTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(popView) userInfo:nil repeats:YES];
    
}


- (void)popView{
    [self.navigationController popViewControllerAnimated:YES];
    [customSearchBar removeFromSuperview];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(xx) userInfo:nil repeats:YES];
    //修改self.timer的优先级与控件一样
    //获取当前的消息循环对象
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    //改变self.timer对象的优先级
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//在滚动事件中计算页码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{//获取滚动的x方向的偏移值
    CGFloat setX = self.scrollview.contentOffset.x;
    //用偏移值加上图片一半的宽度
    CGFloat X = setX + (self.scrollview.frame.size.width *0.5);
    //用x方向的偏移量的值除以一张图片的宽度，取商就是当前滚动到了第几页
    CGFloat cx = X/self.scrollview.frame.size.width;
    //将页码设置给UIPageControll
    self.pc.currentPage = cx;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMGPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor =  [UIColor colorWithWhite:0.9 alpha:0.8];;
    cell.imageName = [NSString stringWithFormat:@"00%ld",(long)indexPath.row + 1];
    cell.nameLabel.text = @"金泛斯品牌";
    switch (indexPath.row) {
        case 0:
            cell.nameLabel.text = @"外套";
            break;
        case 1:
            cell.nameLabel.text = @"短裤";
            break;
        case 2:
            cell.nameLabel.text = @"长裤";
            break;
        case 3:
            cell.nameLabel.text = @"帽子";
            break;
        case 4:
            cell.nameLabel.text = @"连衣裙";
            break;
        case 5:
            cell.nameLabel.text = @"衬衫";
            break;
        case 6:
            cell.nameLabel.text = @"短袖";
            break;
        case 7:
            cell.nameLabel.text = @"胸罩";
            break;
        default:
            cell.nameLabel.text = @"裙子";
            break;
    }
    return cell;
}

- (void) hiddenButton{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIView *)creatscrllview
{
    if(view == nil)
    {
        
        CGFloat imgY = 0;
        CGFloat imgH = 200;
        CGFloat imgW = SCREEN_W;
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 65, imgW, imgH)];
        if (_scrollview == nil) {
            UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 200)];
            self.scrollview = scrollview;
            self.scrollview.delegate = self;
            //添加UIImageview给UIScrollView
            for (int i = 0; i < 4; i++) {
                CGFloat imgX = i * imgW;
                UIImageView *image = [[UIImageView alloc] init];
                image.frame = CGRectMake(imgX, imgY, imgW, imgH);
                NSString *imageName = [NSString stringWithFormat:@"%02d.jpg",i + 1 ];
                image.image = [UIImage imageNamed:imageName];
                [self.scrollview addSubview:image];
                
            }
            //设置scrollview的实际内容大小
            CGFloat vieW = self.scrollview.frame.size.width * 4;
            self.scrollview.contentSize = CGSizeMake(vieW, 0);
            //实现分页
            self.scrollview.pagingEnabled = YES;
            //取消滚动条
            self.scrollview.showsHorizontalScrollIndicator = NO;
            
            UIPageControl *pc = [[UIPageControl alloc]init];
            pc.frame = CGRectMake(SCREEN_W/2-10, 280, 20, 5);
            self.pc = pc;
            self.pc.numberOfPages = 4;
            self.pc.pageIndicatorTintColor = [UIColor brownColor];
            self.pc.currentPageIndicatorTintColor = [UIColor blueColor];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(xx) userInfo:nil repeats:YES];
            NSRunLoop *runloop = [NSRunLoop currentRunLoop];
            [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
            [view addSubview:self.scrollview];
            [self.view bringSubviewToFront:self.pc];
            [self.view addSubview:self.pc];
        }
        
    }
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    categoryViewController *nextVc = [[categoryViewController alloc]init];
    [self.joinTimer invalidate];
    switch (indexPath.row) {
        case 0:
            shops = [XMGShop objectArrayWithFilename:@"chensha.plist"];
            nextVc.shopArray = [NSMutableArray array];
            [nextVc.shopArray addObjectsFromArray:shops];
            [self.navigationController pushViewController:nextVc animated:YES];
            [customSearchBar removeFromSuperview];
            break;
        case 1:
            shops = [XMGShop objectArrayWithFilename:@"duanqun.plist"];
            nextVc.shopArray = [NSMutableArray array];
            [nextVc.shopArray addObjectsFromArray:shops];
            [self.navigationController pushViewController:nextVc animated:YES];
            [customSearchBar removeFromSuperview];
            break;
        case 2:
            shops = [XMGShop objectArrayWithFilename:@"kuzi.plist"];
            nextVc.shopArray = [NSMutableArray array];
            [nextVc.shopArray addObjectsFromArray:shops];
            [self.navigationController pushViewController:nextVc animated:YES];
            [customSearchBar removeFromSuperview];
            break;
        case 3:
            shops = [XMGShop objectArrayWithFilename:@"top.plist"];
            nextVc.shopArray = [NSMutableArray array];
            [nextVc.shopArray addObjectsFromArray:shops];
            [self.navigationController pushViewController:nextVc animated:YES];
            [customSearchBar removeFromSuperview];
            break;
        case 4:
            shops = [XMGShop objectArrayWithFilename:@"lianyiqun.plist"];
            nextVc.shopArray = [NSMutableArray array];
            [nextVc.shopArray addObjectsFromArray:shops];
            [self.navigationController pushViewController:nextVc animated:YES];
            [customSearchBar removeFromSuperview];
            break;
        case 5:
            shops = [XMGShop objectArrayWithFilename:@"chensha.plist"];
            nextVc.shopArray = [NSMutableArray array];
            [nextVc.shopArray addObjectsFromArray:shops];
            [self.navigationController pushViewController:nextVc animated:YES];
            break;
        case 6:
            shops = [XMGShop objectArrayWithFilename:@"chensha.plist"];
            nextVc.shopArray = [NSMutableArray array];
            [nextVc.shopArray addObjectsFromArray:shops];
            [self.navigationController pushViewController:nextVc animated:YES];
            [customSearchBar removeFromSuperview];
            break;
        case 7:
            shops = [XMGShop objectArrayWithFilename:@"xiongzhao.plist"];
            nextVc.shopArray = [NSMutableArray array];
            [nextVc.shopArray addObjectsFromArray:shops];
            [self.navigationController pushViewController:nextVc animated:YES];
            [customSearchBar removeFromSuperview];
            break;
        default:
            shops = [XMGShop objectArrayWithFilename:@"lianyiqun.plist"];
            nextVc.shopArray = [NSMutableArray array];
            [nextVc.shopArray addObjectsFromArray:shops];
            [self.navigationController pushViewController:nextVc animated:YES];
            [customSearchBar removeFromSuperview];
            break;
    }

}

- (void)xx
{
    //1.获取当前的UIPageControl的页码
    NSInteger count = self.pc.currentPage;
    //2.判断页码是佛到最后一页，如果到最后一页，让页码回到第一页。
    if (count == self.pc.numberOfPages - 1) {
        count = 0;
    }
    else{
        count++;
    }
    //3.用每页的宽度*（页码+1）计算下一页的contentOffset.x
    CGFloat Offset = self.scrollview.frame.size.width * count;
    //4.设置UIScrollView的contentOffset等于偏移的值
    //self.scrollview.contentOffset = CGPointMake(Offset, 0);
    //动画方式
    [self.scrollview setContentOffset:CGPointMake(Offset, 0)animated:YES];
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.joinTimer invalidate];
    [self showCheckCodeView:(UISearchBar *)searchBar];
    return true;
}

//展现检查验证码模态框
-(void)showCheckCodeView:(UISearchBar *)searchBar{
    flag = YES;
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    searchTeams *checkCode = [mainStoryboard instantiateViewControllerWithIdentifier:@"checkCode"];
    checkCode.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    checkCode.seacherIteamsBar = searchBar;
    [self.navigationController pushViewController:checkCode animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    if (flag) {
        
    }else{
        customSearchBar.hidden = YES;
        [customSearchBar removeFromSuperview];

    }

}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    customSearchBar.showsCancelButton = YES;
    for(id cc in [searchBar.subviews[0] subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
}

- (void)cancel{
    [self.navigationController popViewControllerAnimated:NO];
    
}

@end
