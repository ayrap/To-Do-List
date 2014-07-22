//
//  Item.h
//  ToDoList
//
//  Created by Ayra Panganiban on 7/22/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * sortOrder;
@property (nonatomic, retain) User *whoWrote;

@end
