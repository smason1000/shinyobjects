
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TiProxy.h" 

@interface ShinyObjectsUtilityProxy : TiProxy 
{
	AVCaptureSession *torchSession;
	AVCaptureOutput  *torchOutput;
}

@property (nonatomic, retain) AVCaptureSession *torchSession;
@property (nonatomic, retain) AVCaptureOutput  *torchOutput;

@end