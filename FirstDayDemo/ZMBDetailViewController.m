//
//  ZMBDetailViewController.m
//  FirstDayDemo
//
//  Created by Zuri Biringer on 1/15/14.
//  Copyright (c) 2014 Zuri Biringer. All rights reserved.
//

#import "ZMBDetailViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ZMBDetailViewController () <UITextFieldDelegate>

- (IBAction)goBackToTableViewController:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *theImageView;
@property (strong, nonatomic) IBOutlet UITextField *twitterTextField;
@property (strong, nonatomic) IBOutlet UITextField *githubTextField;

@end

@implementation ZMBDetailViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.student.studentTwitterName = self.twitterTextField.text;
    NSLog(@"%@", self.student.studentTwitterName);
    self.student.studentGithubName = self.githubTextField.text;
}

- (IBAction)goBackToTableViewController:(id)sender {
    [self saveStudent];
    [self.delegate studentWasEdited:self.student];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveStudent
{
    [self.student setStudentImage:self.theImageView.image];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSLog(@"viewDidLoad");
    
    self.twitterTextField.delegate = self;
    self.githubTextField.delegate = self;
    
    if ([self.student.studentTwitterName isEqualToString:@""]) {
        self.twitterTextField.text = @"Type twitter name";
    } else {
        self.twitterTextField.text = self.student.studentTwitterName;
    }
    if ([self.student.studentGithubName isEqualToString:@""]){
        self.githubTextField.text = @"Type github name";
    } else {
        self.githubTextField.text = self.student.studentGithubName;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (IBAction)startPicker:(id)sender {

    UIActionSheet *mySheet;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        mySheet = [[UIActionSheet alloc] initWithTitle:@"Pick Photo"
                                              delegate:self
                                     cancelButtonTitle:@"cancel"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@"Camera, @Photo Library", nil];
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        mySheet = [[UIActionSheet alloc] initWithTitle:@"Pick Photo"
                                              delegate:self
                                     cancelButtonTitle:@"cancel"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@"Photo Library", nil];
    } else {
        return;
    }
    
    [mySheet showFromBarButtonItem:sender animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *myPicker = [[UIImagePickerController alloc] init];
    myPicker.delegate = self;
    myPicker.allowsEditing = YES;
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Camera"]) {
        myPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Photo Library"]){
        myPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        return;
    }
    
    [self presentViewController:myPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        self.theImageView.image = editedImage;
        
        ALAssetsLibrary *assetsLibrary = [ALAssetsLibrary new];
        
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied || [ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusRestricted) {
            return;
        } else {
            NSLog(@"Metadata: %@", info[UIImagePickerControllerMediaMetadata]);
            [assetsLibrary writeImageToSavedPhotosAlbum:editedImage.CGImage orientation:ALAssetOrientationUp completionBlock:^(NSURL *assetURL, NSError *error) {
                if (error) {
                    NSLog(@"%@", error);
                }
            }];
        }
        
        NSData *jpgData = UIImageJPEGRepresentation(editedImage, 0.5);
        NSString *jpgPath = [[self docsDirPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpeg", self.student.studentName]];
        [jpgData writeToFile:jpgPath atomically:YES];
        
    }];
}

- (NSString *)docsDirPath
{
    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [docsURL path];
}

#pragma mark - additional lifecycle events

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear");
}

@end
