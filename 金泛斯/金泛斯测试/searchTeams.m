//
//  searchTeams.m
//  testVideoAndPicture
//
//  Created by 慧流 on 16/5/29.
//  Copyright © 2016年 范博. All rights reserved.
//

#import "searchTeams.h"
#import "searchModel.h"
#import "MJExtension.h"
#import "itemsCell.h"
#import "IemsModel.h"

@interface searchTeams ()<UISearchBarDelegate>

{
    NSMutableArray *toatalArray;
    
}

@end

@implementation searchTeams

-(void)viewDidLoad
{
    //初始化检索对象
    //发起检索
    toatalArray = [NSMutableArray array];
    NSArray *shops = [IemsModel objectArrayWithFilename:@"kuzi.plist"];
    [toatalArray addObjectsFromArray:shops];
    NSLog(@"1234%@",shops);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.seacherIteamsBar.delegate = self;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@" " style:UIBarButtonItemStylePlain target:self action:@selector(hiddenButton)];
    self.navigationItem.leftBarButtonItem = cancelButton;


}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return toatalArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    itemsCell * tableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"itemCell"];
    if (tableViewCell == nil) {
        tableViewCell =  [[itemsCell alloc]initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:@"itemCell"];
    }
    IemsModel *model = toatalArray[indexPath.row];
    tableViewCell.itemImage.image = [UIImage imageNamed: model.img];
    tableViewCell.price.text = model.price;
    if (model.bao) {
             tableViewCell.isBaoyou.text = @"免运费";
            tableViewCell.isBaoyou.textColor = [UIColor redColor];
    }else{
        tableViewCell.isBaoyou.text = @"不包邮";
    }
    tableViewCell.name.text = model.h;
    tableViewCell.name.lineBreakMode = UILineBreakModeWordWrap;
    tableViewCell.name.numberOfLines = 0;
    return tableViewCell;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [toatalArray removeAllObjects];
  if([searchText isEqualToString:@"上衣"]){
        NSArray *shops = [IemsModel objectArrayWithFilename:@"shangyi.plist"];
        [toatalArray addObjectsFromArray:shops];
        [self.tableView reloadData];
    }else if([searchText isEqualToString:@"裤子"]){
        NSArray *shops = [IemsModel objectArrayWithFilename:@"kuzi.plist"];
        [toatalArray addObjectsFromArray:shops];
        [self.tableView reloadData];
    }else if([searchText isEqualToString:@"帽子"]){
        NSArray *shops = [IemsModel objectArrayWithFilename:@"top.plist"];
        [toatalArray addObjectsFromArray:shops];
        [self.tableView reloadData];
    }
}


- (void) hiddenButton{
//    [self.seacherIteamsBar resignFirstResponder];
//    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

    [self.seacherIteamsBar resignFirstResponder];

    [self.seacherIteamsBar removeFromSuperview];
}
@end


