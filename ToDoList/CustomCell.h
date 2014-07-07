//
//  CustomCell.h
//  ToDoList
//
//  Created by Ayra Panganiban on 7/2/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *accessoryButton;
@property (strong, nonatomic) IBOutlet UIImageView *accessoryCheck;
@end

