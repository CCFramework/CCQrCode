//
//  CCQrCode.m
//  二维码
//
//  Created by 李飞恒 on 16/4/23.
//  Copyright © 2016年 LIFEIHENG. All rights reserved.
//

#import "CCQrCode.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CCQrCode ()<AVCaptureMetadataOutputObjectsDelegate>
{
    BOOL _isForward;
    CGRect _boxFrame;
}
@property (nonatomic, copy) CCQrCodeCallbackFunction funcation;

@end

@implementation CCQrCode

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _isForward = NO;
        self.scanColor = [UIColor cyanColor];
        self.boxColor = [UIColor greenColor];
        
    }
    return self;
}

- (void)boxRect {
    _boxFrame = CGRectMake(_videoPreviewLayer.bounds.size.width*0.2f, _videoPreviewLayer.bounds.size.height*0.2f, self.bounds.size.width-self.bounds.size.width*0.4, self.bounds.size.width-self.bounds.size.width*0.4);
}

- (BOOL)startReading:(CCQrCodeCallbackFunction)callback {
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (!input) {
        // If the user info dictionary doesn’t contain a value for NSLocalizedDescriptionKey, a default string is constructed from the domain and code.
        NSLog(@"scan error:%@",error.localizedDescription);
        return NO;
    }
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    [_captureSession addOutput:output];
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("QrCode", NULL);
    [output setMetadataObjectsDelegate:self queue:dispatchQueue];
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:self.layer.bounds];
    [self.layer addSublayer:_videoPreviewLayer];
    
    [self boxRect];
    
    
    _boxView = [[UIView alloc] initWithFrame:_boxFrame];
    _boxView.layer.borderColor = self.boxColor.CGColor;
    _boxView.layer.borderWidth = 1.0f;
    _boxView.clipsToBounds = YES;
    [self addSubview:_boxView];
    
    //scan link
    _scanLayer = [[UIView alloc] initWithFrame:CGRectMake(0, -50, _boxView.bounds.size.width, 50)];
    _scanLayer.backgroundColor = self.scanColor;
    [_boxView addSubview:_scanLayer];
    //Color fpih
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = _scanLayer.bounds;
    layer.startPoint = CGPointMake(0, 1);
    layer.endPoint   = CGPointMake(0, 0);
    layer.locations  = @[@(0), @(0.1), @(0.5)];
    layer.colors = @[(__bridge id)[UIColor colorWithWhite:0 alpha:1.0].CGColor,
                     (__bridge id)[UIColor colorWithWhite:0 alpha:0.3].CGColor,
                     (__bridge id)[UIColor colorWithWhite:0 alpha:0.0].CGColor];
    
    _scanLayer.layer.mask = layer;
    
    
    self.funcation = callback;

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(moveScanLayer) userInfo:nil repeats:YES];
    [timer fire];
    [_captureSession startRunning];
    return YES;
}



- (void)stopReading {
    [_captureSession stopRunning];
    _captureSession = nil;
    [_scanLayer removeFromSuperview];
    [_videoPreviewLayer removeFromSuperlayer];
}

- (void)moveScanLayer {
    
    CGRect frame = _scanLayer.frame;
    
    if (_scanLayer.frame.origin.y < (self.bounds.size.width-self.bounds.size.width*0.4 + 50)) {
        //Fore and aft type animation
        [UIView beginAnimations:nil context:nil];
        //Start animation
        //animation timer
        [UIView setAnimationDuration:2.f];
        //delegate
        [UIView setAnimationDelegate:self];
        frame.origin.y += 10;
        _scanLayer.frame = frame;
        [UIView commitAnimations];
        
    } else {
        frame.origin.y = 0;
        _scanLayer.frame = frame;
        [self moveScanLayer];
    }

}
static SystemSoundID shake_sound_male_id = 0;

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        if (_isForward == NO) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"5383" ofType:@"wav"];
            if (path) {
                //registered audio
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id);
                AudioServicesPlaySystemSound(shake_sound_male_id); //play audio，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
            }
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); //vibration
            _isForward = YES;

            
            AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
            
            if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
                NSLog(@"scan:%@",metadataObj.stringValue);
                self.funcation(captureOutput, metadataObjects, connection, metadataObj, metadataObj.stringValue);

                //限制作2秒后可扫描
                __weak typeof(self) weakSelf = self;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf setIsForward];
                });
            }

        }
    }
}

- (void)setIsForward {
    _isForward = NO;
}


@end



























