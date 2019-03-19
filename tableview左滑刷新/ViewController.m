//
//  ViewController.m
//  tableview左滑刷新
//
//  Created by 柯木超 on 2019/3/19.
//  Copyright © 2019年 柯木超. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dayDataArray;
@property (nonatomic, strong) NSMutableArray *weakDataArray;
@property (nonatomic, strong) NSMutableArray *totalDataArray;
@property (nonatomic, strong) NSMutableArray *dataArray;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dayDataArray =[NSMutableArray array];
    self.weakDataArray =[NSMutableArray array];
    self.totalDataArray =[NSMutableArray array];
    self.dataArray =[NSMutableArray array];
    
    [self.dayDataArray addObject:@"day1"];
    [self.dayDataArray addObject:@"day2"];
    [self.dayDataArray addObject:@"day3"];
    [self.dayDataArray addObject:@"day4"];
    
    [self.weakDataArray addObject:@"weak1"];
    [self.weakDataArray addObject:@"weak2"];
    [self.weakDataArray addObject:@"weak3"];
    [self.weakDataArray addObject:@"weak4"];
    
    [self.totalDataArray addObject:@"totol1"];
    [self.totalDataArray addObject:@"totol2"];
    [self.totalDataArray addObject:@"totol3"];
    [self.totalDataArray addObject:@"totol4"];
}

- (IBAction)day:(id)sender {
    if ([self.dataArray isEqual:self.weakDataArray] || [self.dataArray isEqual:self.totalDataArray]){
         self.dataArray = [self.dayDataArray copy];
        [self reloadRankData:self.dataArray direction:YES];
    }else {
         self.dataArray = [self.dayDataArray copy];
        [self.tableView reloadData];
    }
}


- (IBAction)zhou:(id)sender {
    if ([self.dataArray isEqual:self.dayDataArray]){
        self.dataArray = [self.weakDataArray copy];
        [self reloadRankData:self.dataArray direction:NO];
    }else if ([self.dataArray isEqual:self.totalDataArray]){
        self.dataArray = [self.weakDataArray copy];
        [self reloadRankData:self.dataArray direction:YES];
    }else {
        self.dataArray = [self.weakDataArray copy];
        [self.tableView reloadData];
    }
}


- (IBAction)nian:(id)sender {
    if ([self.dataArray isEqual:self.totalDataArray]){
        [self.tableView reloadData];
    }else {
        self.dataArray = [self.totalDataArray copy];
        [self reloadRankData:self.dataArray direction:NO];
    }
}


- (void)reloadRankData:(NSArray *)array direction:(BOOL)isLeft {
    self.dataArray = [array mutableCopy];
    [self.tableView reloadData];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionPush;//{kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
    if (isLeft) {
        transition.subtype = kCATransitionFromLeft;
    } else {
        transition.subtype = kCATransitionFromRight;
    }
    //{kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
    [self.tableView.layer addAnimation:transition forKey:nil];
}


#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rankListCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rankListCell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

@end
