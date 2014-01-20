//
//  ZMBCell.h
//  FirstDayDemo
//
//  Created by Zuri Biringer on 1/19/14.
//  Copyright (c) 2014 Zuri Biringer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMBStudent.h"

@interface ZMBCell : UITableViewCell

@property (nonatomic) ZMBStudent *student;

@property (nonatomic) IBOutlet UILabel *studentName;

@end
