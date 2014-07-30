//
//  User.h
//  ToDoList
//
//  Created by Ayra Panganiban on 7/23/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * avatarUrl;
@property (nonatomic, retain) NSSet *items;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addItemsObject:(Item *)value;
- (void)removeItemsObject:(Item *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
