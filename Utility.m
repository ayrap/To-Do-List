//
//  Utility.m
//  ToDoList
//
//  Created by Ayra Panganiban on 7/7/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import "Utility.h"

@implementation Utility
+ (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM d, yyyy h:mma"];
    
    NSString *dateString = [dateFormat stringFromDate:date];
    dateFormat = nil;
    
    return dateString;
}
@end
