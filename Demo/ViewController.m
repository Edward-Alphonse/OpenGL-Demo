//
//  ViewController.m
//  Demo
//
//  Created by zhichang.he on 2019/11/30.
//  Copyright © 2019 zhichang.he. All rights reserved.
//

#import "ViewController.h"
#import "Demo2ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"click" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)clickButton {
    Demo2ViewController *vc = [[Demo2ViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:vc animated:true completion:NULL];
}



@end
