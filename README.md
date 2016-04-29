# CCQrCode

###AVFoundation encapsulation of qr code scanning tools, support for multiple type code.

****
CCQrCode *code = [[CCQrCode alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:code];
    [code startReading:^(AVCaptureOutput *captureOutput, NSArray *metadataObjects, AVCaptureConnection *connection, AVMetadataMachineReadableCodeObject *metadataObj, NSString *stringValue) {
        NSLog(@"%@",stringValue);
    }];
