//
//  AABViewController.m
//  ZoomStartup
//
//  Created by ITDEV on 03/07/2014.
//  Copyright (c) 2014 aliabbas. All rights reserved.
//

#import "AABViewController.h"

@interface AABViewController ()

@end

@implementation AABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) createImage
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    _startupImageView = [[UIImageView alloc] initWithFrame:frame];
    [_startupImageView setImage:[UIImage imageNamed:@"myImageToBeMasked"]];
    [self.view addSubview:_startupImageView];
    
    self.mask = [[CALayer alloc] init];
    self.mask.contents = (__bridge id)([UIImage imageNamed:@"appleLogoMask.png"].CGImage);
    self.mask.bounds = CGRectMake(0, 0, 100, 100);
    self.mask.anchorPoint = CGPointMake(0.5,0.5);
    [self.mask setPosition:CGPointMake(_startupImageView.frame.size.width/2,_startupImageView.frame.size.height/2)];
    _startupImageView.layer.mask = self.mask;
    
    [self animateLogo];
}

-(void) animateLogo
{
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    pathAnimation.duration = 2.0;
    
    
    //As apple say, its optional. Be caution, If the `values' array defines n keyframes, there should be n-1 objects in the timingFunctions array
    CAMediaTimingFunction *firstTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CAMediaTimingFunction *secondTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    pathAnimation.timingFunctions = [[NSArray alloc] initWithObjects:firstTimingFunction, secondTimingFunction, nil];
    
    
    //Three bounds
    CGRect initialBounds = self.mask.bounds;
    CGRect secondBounds = CGRectMake(0, 0, 90, 90);
    CGRect finalBounds = CGRectMake(0, 0, 1500, 1500);
    
    pathAnimation.values = @[[NSValue valueWithCGRect:initialBounds], [NSValue valueWithCGRect:secondBounds], [NSValue valueWithCGRect:finalBounds]];
    pathAnimation.keyTimes = [[NSArray alloc] initWithObjects:@"0",@"0.3",@"1.0", nil];
    
    
    [self.mask addAnimation:pathAnimation forKey:@"bounds"];
    
}

@end
