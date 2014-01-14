//
//  ZMBTableViewController.m
//  FirstDayDemo
//
//  Created by Zuri Biringer on 1/13/14.
//  Copyright (c) 2014 Zuri Biringer. All rights reserved.
//

#import "ZMBTableViewController.h"

@interface ZMBTableViewController ()
@property (strong, nonatomic) NSArray *myStudentsArray;
@property (strong, nonatomic) NSArray *myInstructorsArray;

@end

@implementation ZMBTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    
    NSString *instructor1 = [NSString stringWithFormat:@"John"];
    NSString *instructor2 = [NSString stringWithFormat:@"Brad"];
    
    self.myInstructorsArray = [NSArray arrayWithObjects:instructor1,instructor2, nil];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(doSomething) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
}

- (void)stopRefresh
{
    [self.refreshControl endRefreshing];
}

- (void)doSomething
{
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0){
    return self.myStudentsArray.count;
    } else {
        return self.myInstructorsArray.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0){
        return @"Students";
    } else {
        return @"Instructors";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section==0){
    cell.textLabel.text = [self.myStudentsArray objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.myInstructorsArray objectAtIndex:indexPath.row];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
