//
//  ZMBViewController.m
//  FirstDayDemo
//
//  Created by Zuri Biringer on 1/13/14.
//  Copyright (c) 2014 Zuri Biringer. All rights reserved.
//

#import "ZMBViewController.h"

@interface ZMBViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *myStudentsArray;

@end

@implementation ZMBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSString *student1 = [NSString stringWithFormat:@"Nicholas"];
    NSString *student2 = [NSString stringWithFormat:@"Zuri"];
    NSString *student3 = [NSString stringWithFormat:@"Chad"];
    NSString *student4 = [NSString stringWithFormat:@"Spencer"];
    NSString *student5 = [NSString stringWithFormat:@"Raghav"];
    NSString *student6 = [NSString stringWithFormat:@"Timothy"];
    NSString *student7 = [NSString stringWithFormat:@"Ivan"];
    NSString *student8 = [NSString stringWithFormat:@"Richard"];
    NSString *student9 = [NSString stringWithFormat:@"Bennett"];
    NSString *student10 = [NSString stringWithFormat:@"Christopher"];
    NSString *student11 = [NSString stringWithFormat:@"Matt"];
    NSString *student12 = [NSString stringWithFormat:@"Andrew"];
    NSString *student13 = [NSString stringWithFormat:@"Jeff"];
    NSString *student14 = [NSString stringWithFormat:@"Steven"];
    NSString *student15 = [NSString stringWithFormat:@"Yair"];
    
    self.myStudentsArray = [NSArray arrayWithObjects:student1,student2,student3,student4,student5,student6,student7,student8,student9,student10,student11,student12,student13,student14,student15, nil];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myStudentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.myStudentsArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
