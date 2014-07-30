//
//  SettingCell.h
//  ToDoList
//
//  Created by Ayra Panganiban on 7/30/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import "CustomCell.h"

@interface SettingCell : CustomCell
@property (strong, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) UIButton *btnUploadPhoto;
@property (strong, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (strong, nonatomic) IBOutlet UILabel *shareLabel;
@property (strong, nonatomic) IBOutlet UILabel *logoutLabel;
@end
