# CCQrCode

###AVFoundation encapsulation of qr code scanning tools, support for multiple type code.


****
platform :ios, "7.0"

pod "CCQrCode", "~>1.0.1"



![image](https://raw.githubusercontent.com/CCFramework/CCQrCode/v1.0.1/IMG_0159.jpg)

****
#**introduce**

$ pod search CCQrCode

$ git clone https://github.com/CCFramework/CCQrCode.git




	- (void)viewDidLoad {
    	[super viewDidLoad];
		CCQrCode *code = [[CCQrCode alloc] initWithFrame:self.view.bounds];
	
		[self.view addSubview:code];	
	
    	[code startReading:^(AVCaptureOutput *captureOutput, NSArray *metadataObjects, AVCaptureConnection *connection, AVMetadataMachineReadableCodeObject *metadataObj, NSString *stringValue) {
    
       	 	NSLog(@"%@",stringValue);
        
    	}];
    
	}
