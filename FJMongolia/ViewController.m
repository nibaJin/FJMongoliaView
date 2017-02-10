//
//  ViewController.m
//  FJMongolia
//
//  Created by fujin on 17/2/10.
//  Copyright © 2017年 fujin. All rights reserved.
//

#import "ViewController.h"
#import "FJDisplayListCell.h"
#import "FJMongoliaViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataArray = @[@"矩形蒙层（带圆角）" , @"弧形蒙层（包含圆形）" , @"多个矩形蒙层（带圆角）"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FJDisplayListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FJDisplayListCell"];
    cell.titleLabel.text = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FJMongoliaViewController *mongoliaVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FJMongoliaViewController"];
    mongoliaVC.mongoliaType = indexPath.row;
    [self.navigationController pushViewController:mongoliaVC animated:YES];
}

@end
