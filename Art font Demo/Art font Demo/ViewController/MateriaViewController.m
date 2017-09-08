//
//  MateriaViewController.m
//  Art font Demo
//
//  Created by QD-ZC on 2017/9/8.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "MateriaViewController.h"
#import "CBJMateriaLabel.h"
@interface MateriaViewController ()

@property (weak, nonatomic) CBJMateriaLabel *materiaLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *materiaSegment;

@end

@implementation MateriaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.colorView.hidden = YES;
    
    CBJMateriaLabel *materiaLabel = [[CBJMateriaLabel alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 100)];
    materiaLabel.textAlignment = NSTextAlignmentCenter;
    materiaLabel.font = [UIFont fontWithName:@"Arial-ItalicMT" size:60.f];
    materiaLabel.text = @"Materia";
    materiaLabel.materiaImage = [UIImage imageNamed:@"Golden"];
    self.materiaLabel = materiaLabel;
    [self.view addSubview:materiaLabel];
    
    [self.materiaSegment addTarget:self action:@selector(materiaSegmentValueChanged:) forControlEvents:UIControlEventValueChanged];
}


- (void)materiaSegmentValueChanged:(UISegmentedControl *)materiaSegment
{
    NSString *title = [materiaSegment titleForSegmentAtIndex:materiaSegment.selectedSegmentIndex];
    NSLog(@"The title is %@", title);
    self.materiaLabel.materiaImage = [UIImage imageNamed:title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
