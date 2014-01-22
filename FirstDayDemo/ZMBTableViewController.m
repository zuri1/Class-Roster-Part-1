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

- (NSData *)loadDataFromDisk
{
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    docsPath = [docsPath stringByAppendingPathComponent:@"Bootcamp.plist"];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *plistPath;
    
    if ([fileManager fileExistsAtPath:docsPath]) {
        plistPath = docsPath;
    } else {
        NSError *err;
        plistPath = [[NSBundle mainBundle] pathForResource:@"Bootcamp" ofType:@"plist"];
        [fileManager copyItemAtPath:plistPath toPath:docsPath error:&err];
        if (err) {
            NSLog(@"File copy error: %@", err);
        } else {
            return [self loadDataFromDisk];
        }
    }
    return [NSData dataWithContentsOfFile:plistPath];
}

- (void)movePlistFromBundle
{
    NSString *docsPath = [[self docsDirPath] stringByAppendingPathComponent:@"Bootcamp.plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:docsPath]) {
        NSLog(@"File did exist");
        _students = [NSKeyedUnarchiver unarchiveObjectWithFile:docsPath];
        for (ZMBStudent *student in self.students) {
            NSString *docsDir = [self docsDirPath];
            NSString *imagePath = [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpeg", student.studentName]];
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            if (imageData) {
                NSLog(@"Got An Image");
                UIImage *image = [UIImage imageWithData:imageData];
                student.studentImage = image;
            } else {
                //Placeholder image, like placekitten
            }
        }
        return;
    } else {
        NSLog(@"File didn't exist");
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Bootcamp" ofType:@"plist"];
        NSString *docsDir = [self docsDirPath];
        
        self.myPlistArray = [NSArray arrayWithContentsOfFile:plistPath];
        
        self.students = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dictionary in self.myPlistArray)
        {
            ZMBStudent *newStudent = [[ZMBStudent alloc] init];
            newStudent.studentName = [dictionary objectForKey:@"studentName"];
            newStudent.studentGithubName = [dictionary objectForKey:@"github"];
            newStudent.studentTwitterName = [dictionary objectForKey:@"twitter"];
            
            
            [self.students addObject:newStudent];
        }
        
        [NSKeyedArchiver archiveRootObject:self.students toFile:[docsDir stringByAppendingPathComponent:@"Bootcamp.plist"]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"iOS Bootcamp";
    
    
#pragma mark - load array from plist
    
    
    [self movePlistFromBundle];
    
    
    NSLog(@"%@", self.students);
#pragma mark - pull-to-refresh
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(doSomething) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;

}

- (NSString *)docsDirPath
{
    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [docsURL path];
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
    cell.myImage = [[self.students objectAtIndex:indexPath.row] studentImage];
    
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
