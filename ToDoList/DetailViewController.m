//
//  DetailViewController.m
//  ToDoList
//
//  Created by Ayra Panganiban on 7/2/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController (){
    AppDelegate *appdelegate;
}
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *descTitleLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UILabel *dueDateTitleLabel;
@property (strong, nonatomic) UILabel *dueDateLabel;
@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.nameLabel.text = self.selectedItem.itemName;
    self.descriptionLabel.text = self.selectedItem.itemDescription;
    self.dueDateLabel.text = self.selectedItem.itemDueDate;
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.descTitleLabel];
    [self.view addSubview:self.descriptionLabel];
    [self.view addSubview:self.dueDateTitleLabel];
    [self.view addSubview:self.dueDateLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 100, 20)];
        [_titleLabel setText: @"Title:"];
    }
    return _titleLabel;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 80, 250, 20)];
    }
    return _nameLabel;
}

-(UILabel *)descTitleLabel{
    if(!_descTitleLabel){
        _descTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 105, 250, 20)];
        [_descTitleLabel setText: @"Description:"];
    }
    return _descTitleLabel;
}
-(UILabel *)descriptionLabel{
    if(!_descriptionLabel){
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 105, 250, 20)];
    }
    return _descriptionLabel;
}

-(UILabel *)dueDateTitleLabel{
    if(!_dueDateTitleLabel){
        _dueDateTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 250, 20)];
        [_dueDateTitleLabel setText: @"Due Date:"];
    }
    return _dueDateTitleLabel;
}

-(UILabel *)dueDateLabel{
    if(!_dueDateLabel){
        _dueDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 130, 255, 20)];
        _dueDateLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _dueDateLabel;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
