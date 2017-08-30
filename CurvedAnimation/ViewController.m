//
//  ViewController.m
//  CurvedAnimation
//
//  Created by Shelly Pritchard on 30/08/17.
//  Copyright © 2017 Shelly Pritchard. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *animateBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.animateBtn addTarget:self action:@selector(moveViewInCurvedAnimation) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moveViewInCurvedAnimation {
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;

     UIView *aniView = [[UIView alloc] initWithFrame:CGRectMake(50, screenHeight, 50, 50)];
     [aniView setBackgroundColor:[UIColor redColor]];
     aniView.layer.cornerRadius = 25.0;
     [self.view addSubview:aniView];
     
     
     UIBezierPath *movePath = [UIBezierPath bezierPath];
     [movePath moveToPoint:aniView.center];
     [movePath addQuadCurveToPoint:CGPointMake(screenWidth-50,screenHeight)
     controlPoint:CGPointMake(screenWidth/2,screenHeight-150)];
     CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
     moveAnim.path = movePath.CGPath;
     moveAnim.removedOnCompletion = YES;
     CAAnimationGroup *animGroup = [CAAnimationGroup animation];
     animGroup.animations = [NSArray arrayWithObjects:moveAnim,  nil];
     animGroup.duration = 2.0;
     
     [CATransaction begin]; {
     [CATransaction setCompletionBlock:^{
     [aniView.layer removeAllAnimations];
     [aniView removeFromSuperview];
     }];
     
     [aniView.layer addAnimation:animGroup forKey:nil];
     
     } [CATransaction commit];
     
 

    
}


@end
