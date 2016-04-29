# CCQrCode

###AVFoundation encapsulation of qr code scanning tools, support for multiple type code.


****
![image](https://raw.githubusercontent.com/CCFramework/CCQrCode/v1.0.1/IMG_0159.jpg)

****
#**introduce**



	- (void)viewDidLoad {
    	[super viewDidLoad];
		CCQrCode *code = [[CCQrCode alloc] initWithFrame:self.view.bounds];
	
		[self.view addSubview:code];	
	
    	[code startReading:^(AVCaptureOutput *captureOutput, NSArray *metadataObjects, AVCaptureConnection *connection, AVMetadataMachineReadableCodeObject *metadataObj, NSString *stringValue) {
    
       	 	NSLog(@"%@",stringValue);
        
    	}];
    
	}
