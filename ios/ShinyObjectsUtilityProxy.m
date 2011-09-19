/*
	Implementation file for the Utility object
 */

#import "ShinyObjectsUtilityProxy.h"
#import "TiUtils.h"

@implementation ShinyObjectsUtilityProxy 

@synthesize torchSession;
@synthesize torchOutput;

-(void)dealloc
{
	NSLog(@"dealloc called for ShinyObjectsUtilityProxy");
	[torchOutput release];
	[torchSession release];
	[super dealloc];
}

// hasFlashlight get/set

-(void)setHasFlashlight:(id)value
{
	// read only property
	return;
}

-(AVCaptureDevice *)getDeviceWithFlash
{
	NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
	for (AVCaptureDevice *device in devices)
	{
		if ([device hasFlash] && [device hasTorch])
			return device;
	}
	return nil;
	
}

-(void)lightOn
{
	NSLog(@"Turning torch on.");
	
	// we need to create (or reuse) a session and add the devices
	
	AVCaptureDevice *device = [self getDeviceWithFlash];
	if (device != nil)
	{		
		// Create an AV session
		AVCaptureSession *session;
		if (torchSession != nil)
			session = torchSession;	
		else
			session = [[AVCaptureSession alloc] init];
		
		// Start session configuration
		[session beginConfiguration];
		[device lockForConfiguration:nil];
		
		if (torchSession == nil)
		{
			// Create device input and add to current session
			AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
			
			// Create video output and add to current session
			
			AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
			
			// add the input and output
			[session addInput:input];
			[session addOutput:output];			

			// save the session variables
			[self setTorchSession:session];
			[self setTorchOutput:output];
		}
		
		// enable the torch
		[device setTorchMode:AVCaptureTorchModeOn];
		
		[device unlockForConfiguration];
		[session commitConfiguration];
				
		NSLog(@"Turning Torch on for device %@.", [device localizedName]);
			
		// Set torch to on
		[session startRunning];
	}
	else
	{
		NSLog(@"Device does not have Torch capability.");
	}
}

-(void)lightOff
{
	NSLog(@"Turning torch off.");
	
	// we need to create (or reuse) a session and add the devices
	
	AVCaptureDevice *device = [self getDeviceWithFlash];
	if (device != nil)
	{		
		// Create an AV session
		AVCaptureSession *session;
		if (torchSession != nil)
			session = torchSession;	
		else
			session = [[AVCaptureSession alloc] init];
		
		// Start session configuration
		[session beginConfiguration];
		[device lockForConfiguration:nil];
		
		if (torchSession == nil)
		{
			// Create device input and add to current session
			AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
			
			// Create video output and add to current session
			
			AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
			
			// add the input and output
			[session addInput:input];
			[session addOutput:output];			
			
			// save the session variables
			[self setTorchSession:session];
			[self setTorchOutput:output];
		}
		
		// enable the torch
		[device setTorchMode:AVCaptureTorchModeOff];
		
		[device unlockForConfiguration];
		[session commitConfiguration];
		
		NSLog(@"Turning Torch off for device %@.", [device localizedName]);
		
		// Set torch to on
		[session startRunning];
	}
	else
	{
		NSLog(@"Device does not have Torch capability.");
	}
}

-(id)hasFlashlight
{	
	AVCaptureDevice *device = [self getDeviceWithFlash];	
	if (device != nil)
	{
		NSLog(@"Device has Torch capability.");
		return [NSNumber numberWithInt:1];
	}
	else
	{
		NSLog(@"Device does not have Torch capability.");
		return [NSNumber numberWithInt:0];
	}
}

-(void)flashlight:(id)args
{	
	int mode = [[args objectAtIndex:0] intValue];
	
	if (mode == 1)
		[self lightOn];
	else
		[self lightOff];
	
}

-(void)sleep:(id)args
{
	// ensure we have at least 1 argument and it runs on the UI thread
	ENSURE_UI_THREAD_1_ARG(args);
	
	float seconds = [[args objectAtIndex:0] floatValue];
	NSLog(@"Sleeping for %f seconds", seconds);
	[NSThread sleepForTimeInterval:seconds];
}

@end