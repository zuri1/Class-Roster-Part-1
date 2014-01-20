//
//  ZMBDetailViewController.h
//  FirstDayDemo
//
//  Created by Zuri Biringer on 1/15/14.
//  Copyright (c) 2014 Zuri Biringer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMBStudent.h"

@protocol ZMBDetailViewControllerDelegate <NSObject>

- (void)studentWasEdited:(ZMBStudent *)student;

@end

@interface ZMBDetailViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) id<ZMBDetailViewControllerDelegate> delegate;
@property (nonatomic, weak) ZMBStudent *student;

@end
