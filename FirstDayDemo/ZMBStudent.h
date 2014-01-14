//
//  ZMBStudent.h
//  FirstDayDemo
//
//  Created by Zuri Biringer on 1/14/14.
//  Copyright (c) 2014 Zuri Biringer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMBStudent : NSObject

@property (strong, nonatomic) NSString *studentName;
@property (strong, nonatomic) UIImage *studentImage;

-(id)initWithStudentName:(NSString *)aStudentName
                   image:(UIImage *)aStudentImage;

@end
