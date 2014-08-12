//
//  AppDelegate.h
//  ToDoList
//
//  Created by Ayra Panganiban on 6/23/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"
#import <RestKit/RestKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *toDoItems;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
-(NSArray*)getAllTodoItems;
-(void)logoutUser;
-(void)configureRestKit;
@end
