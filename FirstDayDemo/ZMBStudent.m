//
//  ZMBStudent.m
//  FirstDayDemo
//
//  Created by Zuri Biringer on 1/14/14.
//  Copyright (c) 2014 Zuri Biringer. All rights reserved.
//

#import "ZMBStudent.h"

@implementation ZMBStudent

-(id)init
{
    self = [super init];
    return self;
}

-(id)initWithStudentName:(NSString *)aStudentName
                   image:(UIImage *)aStudentImage{
    self = [super init];
    if (self) {
        self.studentName = aStudentName;
        self.studentImage = aStudentImage;
    }
    return self;
}

@end
