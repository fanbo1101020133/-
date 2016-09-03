//
//  ViewController.m
//  金泛斯测试
//
//  Created by 慧流 on 16/6/12.
//  Copyright © 2016年 范博. All rights reserved.
//

#import "ViewController.h"
#import "nextViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIImageView *currentImageView;   // 当前imageView
@property (nonatomic,weak) UIImageView *nextImageView;      // 下一个imageView
@property (nonatomic,weak) UIImageView *preImageView;       //上一个imageView
@property (nonatomic,assign) BOOL isDragging;               //是否正在拖动
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)NSTimer *hiddenTimer;                 //设置动画
@property(nonatomic,strong)UITapGestureRecognizer* tap;
@property(nonatomic) int timeStamp;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"金泛斯店铺";
    UIScrollView *scrollView =[[UIScrollView alloc] init];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    scrollView.frame = CGRectMake(0, 0, width, height);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    _tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNavBar)];
    self.hiddenTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTimeStamp) userInfo:nil repeats:true];
    [self.view addGestureRecognizer:_tap];
    [self.scrollView setContentSize:CGSizeMake(width * 3, height)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //  设置自动分页
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    //  设置当前点
    self.scrollView.contentOffset = CGPointMake(width, 0);
    //  设置是否有边界
    self.scrollView.bounces = YES;
    UIImageView *currentImageView =[[UIImageView alloc] init];
    currentImageView.image = [UIImage imageNamed:@"1"];
    [self.scrollView addSubview:currentImageView];
    self.currentImageView = currentImageView;
    self.currentImageView.frame = CGRectMake(width, 0, width, height);
    self.currentImageView.contentMode = UIViewContentModeScaleAspectFill;
    //  初始化下一个视图
    UIImageView *nextImageView = [[UIImageView alloc] init];
    nextImageView.image = [UIImage imageNamed:@"2"];
    [self.scrollView addSubview:nextImageView];
    self.nextImageView = nextImageView;
    self.nextImageView.frame = CGRectMake(width * 2, 0, width, height);
    self.nextImageView.contentMode = UIViewContentModeScaleAspectFill;
    //  初始化上一个视图
    UIImageView *preImageView =[[UIImageView alloc] init];
    preImageView.image = [UIImage imageNamed:@"5"];
    preImageView.frame = CGRectMake(0, 0, width, height);
    [self.scrollView addSubview:preImageView];
    self.scrollView.userInteractionEnabled = NO;
    self.preImageView = preImageView;
    self.preImageView.contentMode =UIViewContentModeScaleAspectFill;
    [self.navigationController.navigationBar setHidden:true];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}
- (void)update:(NSTimer *)timer{
    
    CGPoint offSet = self.scrollView.contentOffset;
    offSet.x +=offSet.x;
    [self.scrollView setContentOffset:offSet animated:YES];
    if (offSet.x >= self.view.frame.size.width *2) {
        CGPoint offSet = self.scrollView.contentOffset;
        offSet.x = self.view.frame.size.width;
        
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}
//  停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    //static var i  = 1; //当前展示的是第几张图片
    static int i = 1;
    float offset = self.scrollView.contentOffset.x;
    if (self.nextImageView.image == nil || self.preImageView.image == nil) {
        //  加载下一个视图
        NSString *imageName1 = [NSString stringWithFormat:@"%d",i == 5 ? 1:i +1];
        _nextImageView.image = [UIImage imageNamed:imageName1];
        // 加载上一个视图
        NSString *imageName2 = [NSString stringWithFormat:@"%d",i==1 ?5:i-1];
        _preImageView.image = [UIImage imageNamed:imageName2];
    }
    if(offset ==0){
        _currentImageView.image = _preImageView.image;
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        _preImageView.image = nil;
        if (i == 1) {
            i =5;
        } else{
            i-=1;
        }
    }
    if (offset == scrollView.bounds.size.width * 2) {
        _currentImageView.image = _nextImageView.image;
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        _nextImageView.image = nil;
        if (i == 5) {
            i = 1 ;
        }else{
            i += 1 ;
        }
    }
    
}

- (BOOL)shouldAutorotate
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskPortrait;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goNextPage:(id)sender {
    nextViewController * nextVc = [[nextViewController alloc]init];
    [self.navigationController pushViewController:nextVc animated:true];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.hiddenTimer invalidate];
     [self.timer invalidate];
    [self.navigationController.navigationBar setHidden:false];
    self.navigationController.navigationBar.hidden = NO;
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

