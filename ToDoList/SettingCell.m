//
//  SettingCell.m
//  ToDoList
//
//  Created by Ayra Panganiban on 7/30/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(UIImageView *)photoView{
    if(!_photoView){
        _photoView = [[UIImageView alloc] initWithFrame:CGRectMake(20,0,100,100)];
        _photoView.image = [UIImage imageNamed:@"avatar.png"];
    }
    return _photoView;
}

-(UIButton *)btnUploadPhoto{
    if(!_btnUploadPhoto){
        _btnUploadPhoto = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnUploadPhoto setTitle:@"Upload Photo" forState:UIControlStateNormal];
        [_btnUploadPhoto setFrame:CGRectMake(_photoView.frame.origin.x + 130, 70, 200, 50)];
        [_btnUploadPhoto setBackgroundColor:[UIColor whiteColor]];
        [_btnUploadPhoto setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnUploadPhoto sizeToFit];
    }
    return _btnUploadPhoto;
}

-(UILabel *)feedbackLabel{
    if(!_feedbackLabel){
        _feedbackLabel = [[UILabel alloc] init];
        _feedbackLabel.textColor = [UIColor blackColor];
        _feedbackLabel.font      = [UIFont systemFontOfSize:15.0];
        _feedbackLabel.frame     = CGRectMake(20, 5, 300, 20);
        _feedbackLabel.text = @"Send Feedback";
    }
    return _feedbackLabel;
}

-(UILabel *)shareLabel{
    if(!_shareLabel){
        _shareLabel = [[UILabel alloc] init];
        _shareLabel.textColor = [UIColor blackColor];
        _shareLabel.font      = [UIFont systemFontOfSize:15.0];
        _shareLabel.frame     = CGRectMake(20, 5, 300, 20);
        _shareLabel.text = @"Share to a Friend";
    }
    return _shareLabel;
}

-(UILabel *)logoutLabel{
    if(!_logoutLabel){
        _logoutLabel = [[UILabel alloc] init];
        _logoutLabel.textColor = [UIColor blackColor];
        _logoutLabel.font      = [UIFont systemFontOfSize:15.0];
        _logoutLabel.frame     = CGRectMake(20, 5, 300, 20);
        _logoutLabel.text = @"Log Out";
    }
    return _logoutLabel;
}

@end
