//
//  ZMBDetailViewController.m
//  FirstDayDemo
//
//  Created by Zuri Biringer on 1/15/14.
//  Copyright (c) 2014 Zuri Biringer. All rights reserved.
//

#import "ZMBDetailViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ZMBDetailViewController ()

- (IBAction)goBackToTableViewController:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *theImageView;

@end

@implementation ZMBDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (IBAction)goBackToTableViewController:(id)sender {

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
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
    }];
}

- (NSString *)docsDirPath
{
    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [docsURL path];
}

@end
