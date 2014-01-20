//
//  ZMBCell.m
//  FirstDayDemo
//
//  Created by Zuri Biringer on 1/19/14.
//  Copyright (c) 2014 Zuri Biringer. All rights reserved.
//

#import "ZMBCell.h"

@implementation ZMBCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
