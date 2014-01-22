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

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.studentName = [aDecoder decodeObjectForKey:@"studentName"];
    self.studentTwitterName = [aDecoder decodeObjectForKey:@"studentTwitterName"];
    self.studentGithubName = [aDecoder decodeObjectForKey:@"studentGithubName"];
    self.studentImage = [aDecoder decodeObjectForKey:@"studentImage"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.studentName forKey:@"studentName"];
    [aCoder encodeObject:self.studentTwitterName forKey:@"studentTwitterName"];
    [aCoder encodeObject:self.studentGithubName forKey:@"studentGithubName"];
    [aCoder encodeObject:self.studentImage forKey:@"studentImage"];
    
}

@end
