//
//  DetailViewController.h
//  ToDoList
//
//  Created by Ayra Panganiban on 7/2/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"
#import "Utility.h"

@interface DetailViewController : UIViewController
@property (strong, nonatomic) ToDoItem *selectedItem;
@end
