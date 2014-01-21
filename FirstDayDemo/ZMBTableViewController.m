//
//  ZMBTableViewController.m
//  FirstDayDemo
//
//  Created by Zuri Biringer on 1/13/14.
//  Copyright (c) 2014 Zuri Biringer. All rights reserved.
//

#import "ZMBTableViewController.h"
#import "ZMBStudent.h"
#import "ZMBDetailViewController.h"
#import "ZMBCell.h"

@interface ZMBTableViewController () <ZMBDetailViewControllerDelegate>

@property (strong, nonatomic) NSArray *myPlistArray;
@property (strong, nonatomic) NSMutableArray *students;

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

    self.title = @"iOS Bootcamp";
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(doSomething) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
#pragma mark - load array from plist
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Bootcamp" ofType:@"plist"];
    self.myPlistArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    self.students = [[NSMutableArray alloc] initWithCapacity:self.myPlistArray.count];
    
    for (NSDictionary *dictionary in self.myPlistArray)
    {
        ZMBStudent *newStudent = [[ZMBStudent alloc] init];
        newStudent.studentName = [dictionary objectForKey:@"name"];
        newStudent.studentGithubName = [dictionary objectForKey:@"github"];
        newStudent.studentTwitterName = [dictionary objectForKey:@"twitter"];
        [self.students addObject:newStudent];
        NSLog(@"%@", self.myPlistArray);
    }
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.students.count;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if(section==0){
//        return @"Students";
//    } else {
//        return @"Instructors";
//    }
//} 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ZMBCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
//    ZMBStudent *tempStudent = [self.myPlistNamesArray objectAtIndex:indexPath.row];
    cell.studentName.text = [[self.students objectAtIndex:indexPath.row] studentName];
    cell.myImageView.image = [[self.students objectAtIndex:indexPath.row] studentImage];
    
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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailViewSegue"]) {
        ZMBDetailViewController *detailVC = (ZMBDetailViewController *)segue.destinationViewController;
        detailVC.delegate = self;
        detailVC.student = _students[[self.tableView indexPathForSelectedRow].row];
    }
}

- (void)studentWasEdited:(ZMBStudent *)student
{
    [self.tableView reloadData];
    NSLog(@"studentWasEdited happened");
}

@end
