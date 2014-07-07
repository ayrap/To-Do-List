//
//  AddViewController.h
//  ToDoList
//
//  Created by Ayra Panganiban on 7/1/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@interface AddViewController : UIViewController
@property ToDoItem *toDoItem;
//Actions
- (IBAction)clickButton:(UIButton *)sender;
@end
