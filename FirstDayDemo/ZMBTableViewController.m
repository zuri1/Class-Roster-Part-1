//
//  ZMBTableViewController.m
//  FirstDayDemo
//
//  Created by Zuri Biringer on 1/13/14.
//  Copyright (c) 2014 Zuri Biringer. All rights reserved.
//

#import "ZMBTableViewController.h"
#import "ZMBStudent.h"

@interface ZMBTableViewController ()
@property (strong, nonatomic) NSArray *myStudentsArray;
@property (strong, nonatomic) NSArray *myInstructorsArray;
@property (strong, nonatomic) NSArray *myPlistArray;
@property (strong, nonatomic) NSMutableArray *myPlistNamesArray;

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
//    NSDictionary *plistKeyDict = [self.myPlistArray objectAtIndex:0];
//    NSDictionary *nameKeyDict = [plistKeyDict objectForKey:@"name"];
    
    self.myPlistNamesArray = [[NSMutableArray alloc] initWithCapacity:self.myPlistArray.count];
    
    for (NSDictionary *dictionary in self.myPlistArray)
    {
        ZMBStudent *newStudent = [[ZMBStudent alloc] init];
        newStudent.studentName = [dictionary objectForKey:@"name"];
        [self.myPlistNamesArray addObject:newStudent];
        NSLog(@"%@", self.myPlistNamesArray);
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
    return self.myPlistNamesArray.count;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
//    ZMBStudent *tempStudent = [self.myPlistNamesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [[self.myPlistNamesArray objectAtIndex:indexPath.row] studentName];
    
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
