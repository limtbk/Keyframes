/* Copyright 2016-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the license found in the
 * LICENSE-sample file in the root directory of this source tree.
 */

#import "ViewController.h"

@import Keyframes;

@interface ViewController()

@property (strong) KFVectorLayer *sampleVectorLayer;

@end

@implementation ViewController

- (KFVector *)loadSampleVectorFromDisk:(NSString *)fileName
{
    NSData *data = [NSData dataWithContentsOfFile:fileName];
    NSDictionary *sampleVectorDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    KFVector *sampleVector = KFVectorFromDictionary(sampleVectorDictionary);
    return sampleVector;
}

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dragNDrop:) name:@"DragNDrop" object:nil];

}

- (void)viewWillDisappear
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DragNDrop" object:nil];
}

- (void)dragNDrop:(NSNotification *)notification
{
    [self openFile:notification.object];
}

- (void)openFile:(NSString *)fileName
{
    KFVector *sampleVector = [self loadSampleVectorFromDisk:fileName];
    
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [[NSColor whiteColor] CGColor];
    
    if (self.sampleVectorLayer) {
        [self.sampleVectorLayer pauseAnimation];
        [self.sampleVectorLayer removeFromSuperlayer];
    }
    
    self.sampleVectorLayer = [KFVectorLayer new];
    self.sampleVectorLayer.frame = CGRectMake(self.view.bounds.size.width / 2 - 200, self.view.bounds.size.height / 2 - 200, 400, 400);
    self.sampleVectorLayer.faceModel = sampleVector;
    
    [self.view.layer addSublayer:self.sampleVectorLayer];
    
    [self.sampleVectorLayer startAnimation];
}

- (void)viewDidLayout
{
    NSLog(@"viewDidLayout");
    [super viewDidLayout];

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationDuration:0];
    {
        self.sampleVectorLayer.frame = CGRectMake(self.view.bounds.size.width / 2 - 200, self.view.bounds.size.height / 2 - 200, 400, 400);
    }
    [CATransaction commit];
}

@end
