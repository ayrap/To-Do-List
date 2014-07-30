//
//  TabBarController.m
//  ToDoList
//
//  Created by Ayra Panganiban on 7/1/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import "TabBarController.h"
#import "AddViewController.h"
#import "ListTableViewController.h"
#import "SettingsTableViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

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
    
    //controllers
    AddViewController *view1 = [[AddViewController alloc] init];
    ListTableViewController *view2 = [[ListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    SettingsTableViewController *view3 = [[SettingsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    //navigation controllers
    UINavigationController *listNavigationController = [[UINavigationController alloc] initWithRootViewController:view2];
    UINavigationController *settingNavigationController = [[UINavigationController alloc] initWithRootViewController:view3];
    
    NSMutableArray *tabViewControllers = [[NSMutableArray alloc] init];
    [tabViewControllers addObject:view1];
    [tabViewControllers addObject:listNavigationController];
    [tabViewControllers addObject:settingNavigationController];
    
    [self setViewControllers:tabViewControllers];
    
    //tab bar items
    view1.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:@"Add"
                                  image:[UIImage imageNamed:@"add.png"]
                                    tag:1];
    view2.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:@"List"
                                  image:[UIImage imageNamed:@"list.png"]
                                    tag:2];
    view3.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:@"Settings"
                                  image:[UIImage imageNamed:@"setting.png"]
                                    tag:3];
    
    //add navigation
    [view2.view addSubview:listNavigationController.view];
    [view3.view addSubview:settingNavigationController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
