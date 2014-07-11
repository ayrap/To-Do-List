//
//  Item.h
//  ToDoList
//
//  Created by Ayra Panganiban on 7/11/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) User *whoWrote;

@end
