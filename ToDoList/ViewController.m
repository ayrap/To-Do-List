//
//  ViewController.m
//  ToDoList
//
//  Created by Ayra Panganiban on 6/23/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import "ViewController.h"
#import "TabBarController.h"

@interface ViewController ()
@property (strong, nonatomic) UILabel *appLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UITextField *nameText;
@property (strong, nonatomic) UIButton *btn;
@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.appLabel];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.nameText];
    [self.view addSubview:self.btn];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)clickButton:(UIButton *)sender {
    if (_nameText.text.length == 0) {
        [self addAlertView];
    }
    else {
        _appLabel.text = [NSString stringWithFormat:@"%@%@!", @"Hello ", _nameText.text];
        UITabBarController *tbc = [[TabBarController alloc]
                                   initWithNibName:@"MainTabBarController"
                                   bundle:nil];
        tbc.selectedIndex=0;
        [self presentViewController:tbc animated:YES completion:nil];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([_nameText isFirstResponder] && [touch view] != _nameText) {
        [_nameText resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


-(UILabel *)appLabel {
    if(!_appLabel) {
        _appLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, 200, 40)];
        [_appLabel setText: @"My To-Do App"];
        [_appLabel setTextColor: [UIColor orangeColor]];
    }
    return _appLabel;
}

-(UILabel *)nameLabel {
    if(!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 200, 30)];
        [_nameLabel setText: @"Enter your Name:"];
    }
    return _nameLabel;
}

-(UITextField *)nameText{
    if(!_nameText){
        _nameText = [[UITextField alloc] initWithFrame:CGRectMake(30, 140, 260, 40)];
        _nameText.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
        _nameText.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        _nameText.backgroundColor=[UIColor whiteColor];
        _nameText.placeholder=@"Name...";
        _nameText.layer.cornerRadius=8.0f;
        _nameText.layer.masksToBounds=YES;
        _nameText.layer.borderColor=[[UIColor redColor]CGColor];
        _nameText.layer.borderWidth= 1.0f;
        _nameText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _nameText.textAlignment = NSTextAlignmentCenter;
    }
    return _nameText;
}

-(UIButton *)btn{
    if(!_btn){
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btn addTarget:self
                action:@selector(clickButton:)
      forControlEvents:UIControlEventTouchDown];
        [_btn setTitle:@" Submit " forState:UIControlStateNormal];
        [_btn setFrame:CGRectMake(30, 190, 260, 40)];
        [_btn setBackgroundColor:[UIColor blackColor]];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn sizeToFit];
    }
    return _btn;
}

-(void)addAlertView{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"Warning!" message:@"Please enter name" delegate:nil
                                             cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

@end
