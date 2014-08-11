//
//  ViewController.h
//  ToDoList
//
//  Created by Ayra Panganiban on 6/23/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController : UIViewController<FBLoginViewDelegate, UITextFieldDelegate>
//Actions
- (IBAction)clickButton:(UIButton *)sender;
@end
