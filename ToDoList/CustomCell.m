//
//  CustomCell.m
//  ToDoList
//
//  Created by Ayra Panganiban on 7/2/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import "CustomCell.h"
#import "DetailViewController.h"

@implementation CustomCell

- (UILabel *)nameLabel
{
    if(!_nameLabel)
    {
        _nameLabel           = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font      = [UIFont systemFontOfSize:15.0];
        _nameLabel.frame     = CGRectMake(40, 5, 300, 20);
    }
    return _nameLabel;
}

- (UILabel *)descriptionLabel
{
    if(!_descriptionLabel)
    {
        _descriptionLabel           = [[UILabel alloc] init];
        _descriptionLabel.textColor = [UIColor blackColor];
        _descriptionLabel.font      = [UIFont systemFontOfSize:12.0];
        _descriptionLabel.frame     = CGRectMake(40, 25, 300, 15);
    }
    return _descriptionLabel;
}

- (UILabel *)dateLabel
{
    if(!_dateLabel)
    {
        _dateLabel           = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor blackColor];
        _dateLabel.font      = [UIFont systemFontOfSize:12.0];
        _dateLabel.frame     = CGRectMake(40, 40, 300, 15);
    }
    return _dateLabel;
}

- (UIButton *)accessoryButton
{
    if(!_accessoryButton){
        _accessoryButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_accessoryButton setTitle:@">" forState:UIControlStateNormal];
        [_accessoryButton setFrame:CGRectMake(280, 5, 30, 48)];
        [_accessoryButton setBackgroundColor:[UIColor blackColor]];
        [_accessoryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _accessoryButton;
}

- (UIImageView *)accessoryCheck
{
    if(!_accessoryCheck) {
        _accessoryCheck       = [[UIImageView alloc] init];
        _accessoryCheck.image = [UIImage imageNamed:@"check-mark.png"];
        _accessoryCheck.frame      = CGRectMake(10, 10, 20, 20);
        _accessoryCheck.hidden = YES;

    }
    return _accessoryCheck;
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
