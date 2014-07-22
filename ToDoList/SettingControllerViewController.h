//
//  SettingControllerViewController.h
//  ToDoList
//
//  Created by Ayra Panganiban on 7/14/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingControllerViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIButton *btnSelectPhoto;
@property (strong, nonatomic) UIButton *btnTakePhoto;
- (IBAction)takePhoto:  (UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;
@end
