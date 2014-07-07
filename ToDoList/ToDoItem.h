//
//  ToDoItem.h
//  ToDoList
//
//  Created by Ayra Panganiban on 7/1/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject
@property NSString *itemName;
@property NSString *itemDescription;
@property BOOL completed;
@property NSString *itemDueDate;
@end
