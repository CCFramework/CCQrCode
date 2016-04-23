//
//  ViewController.m
//  CCQrCodeDemo
//
//  Created by 李飞恒 on 16/4/23.
//  Copyright © 2016年 LIFEIHENG. All rights reserved.
//

#import "ViewController.h"
#import "CCQrCode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CCQrCode *code = [[CCQrCode alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:code];
    [code startReading:^(AVCaptureOutput *captureOutput, NSArray *metadataObjects, AVCaptureConnection *connection, AVMetadataMachineReadableCodeObject *metadataObj, NSString *stringValue) {
        NSLog(@"%@",stringValue);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
