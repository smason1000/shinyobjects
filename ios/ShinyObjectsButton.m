// Implementation file for button module

#import "ShinyObjectsButton.h" 
#import "ShinyObjectsButtonProxy.h" 

#import "TiUtils.h"

const UIControlEvents highlightingTouches2 = UIControlEventTouchDown|UIControlEventTouchDragEnter;
const UIControlEvents unHighlightingTouches2 = UIControlEventTouchCancel|UIControlEventTouchDragExit|UIControlEventTouchUpInside;

@implementation ShinyObjectsButton

#pragma mark Internal

-(void)dealloc
{
	[button removeTarget:self action:@selector(clicked:event:) forControlEvents:UIControlEventTouchUpInside];
	[button removeTarget:self action:@selector(tapped:event:) forControlEvents:UIControlEventTouchDownRepeat];
	[button removeTarget:self action:@selector(highlightOn:) forControlEvents:highlightingTouches2];
	[button removeTarget:self action:@selector(highlightOff:) forControlEvents:unHighlightingTouches2];
	RELEASE_TO_NIL(button);
	[super dealloc];
}

-(BOOL)hasTouchableListener
{
	// since this guy only works with touch events, we always want them
	// just always return YES no matter what listeners we have registered
	return YES;
}

- (void)initLayers
{
    [self initBorder];
    [self addShineLayer];
    [self addHighlightLayer];
}

- (void)initBorder 
{
    CALayer *layer = button.layer;
	if (borderRadius <= 0)
    	layer.cornerRadius = 8.0f;
	else
    	layer.cornerRadius = borderRadius;
    layer.masksToBounds = YES;
    layer.borderWidth = 1.0f;
    //layer.borderColor = [UIColor colorWithWhite:0.5f alpha:0.2f].CGColor;
	layer.borderColor = [UIColor colorWithRed:100/255 green:100/255 blue:100/255 alpha:0.2f].CGColor;
}


- (void)addShineLayer 
{
    shineLayer = [CAGradientLayer layer];
    shineLayer.frame = button.layer.bounds;
    shineLayer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:0.45f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.85f alpha:0.4f].CGColor,
                         nil];
    shineLayer.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.8f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    [button.layer addSublayer:shineLayer];
}

#pragma mark -
#pragma mark Highlight button while touched

- (void)addHighlightLayer 
{
    highlightLayer = [CALayer layer];
    highlightLayer.backgroundColor = [UIColor colorWithRed:0.25f green:0.25f blue:0.25f alpha:0.75].CGColor;
    highlightLayer.frame = button.layer.bounds;
    highlightLayer.hidden = YES;
    [button.layer insertSublayer:highlightLayer below:shineLayer];
}


- (void)setHighlighting:(BOOL)highlight 
{
	NSLog(@"highlight = %d", highlight);
    highlightLayer.hidden = !highlight;
    [button setHighlighted:highlight];
}

/*
-(void)setHighlighting:(BOOL)isHiglighted
{
	ComTestButtonProxy * ourProxy = (ComTestButtonProxy *)[self proxy];
	
	NSArray * proxyChildren = [ourProxy children];
	for (TiViewProxy * thisProxy in proxyChildren)
	{
		TiUIView * thisView = [thisProxy view];
		if ([thisView respondsToSelector:@selector(setHighlighted:)])
		{
			[(id)thisView setHighlighted:isHiglighted];
		}
	}
}
*/

-(void)handleControlEvents:(UIControlEvents)events
{
	eventAlreadyTriggered = YES;
	if (events & highlightingTouches2) 
	{
		[button setHighlighted:YES];
		[self setHighlighting:YES];
	}
	else if (events & unHighlightingTouches2) 
	{
		[button setHighlighted:NO];
		[self setHighlighting:NO];
	}
	eventAlreadyTriggered = NO;
	
	[super handleControlEvents:events];
}

-(IBAction)highlightOn:(id)sender
{
	[self setHighlighting:YES];
	if (!eventAlreadyTriggered && [self.proxy _hasListeners:@"touchstart"])
	{
		[self.proxy fireEvent:@"touchstart" withObject:nil];
	}
}

-(IBAction)highlightOff:(id)sender
{
	[self setHighlighting:NO];
	if (!eventAlreadyTriggered && [self.proxy _hasListeners:@"touchend"])
	{
		[self.proxy fireEvent:@"touchend" withObject:nil];
	}
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
	[button setFrame:bounds];
	[self initLayers];
}

-(void)clicked:(id)sender event:(UIEvent*)event
{
	if ([self.proxy _hasListeners:@"click"])
	{
		// TODO: This is not cool.  It COULD be that any control with 'specialized' handling like buttons does not report the same information as TiUIViews!
		// For now, let's just hack in some x and y...
		UITouch* touch = [[event touchesForView:sender] anyObject];
		NSMutableDictionary *evt = [NSMutableDictionary dictionaryWithDictionary:[TiUtils pointToDictionary:[touch locationInView:self]]];
		[evt setValue:[TiUtils pointToDictionary:[touch locationInView:nil]] forKey:@"globalPoint"];
		
		[self.proxy fireEvent:@"click" withObject:evt];
	}
}

-(UIButton*)button
{
	if (button == nil)
	{
		//id backgroundImage = [self.proxy valueForKey:@"backgroundImage"];
		//UIButtonType defaultType = backgroundImage != nil ? UIButtonTypeCustom : UIButtonTypeRoundedRect;
		//style = [TiUtils intValue:[self.proxy valueForKey:@"style"] def:defaultType];
		borderRadius = [TiUtils floatValue:[self.proxy valueForKey:@"borderRaduis"] def:8.0f];
		WebFont *f = [TiUtils fontValue:[self.proxy valueForKey:@"font"] def:nil];
		
		style = UIButtonTypeCustom;
		UIView *btn = [UIButton buttonWithType:style];
		button = (UIButton*)[btn retain];
		[self addSubview:button];
		[TiUtils setView:button positionRect:self.bounds];
		if (style == UIButtonTypeCustom)
		{
			[button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		}
		if (f == nil)
		{
			[[button titleLabel] setFont:[UIFont boldSystemFontOfSize:15]];
		}
		[button addTarget:self action:@selector(clicked:event:) forControlEvents:UIControlEventTouchUpInside];
		[button addTarget:self action:@selector(tapped:event:) forControlEvents:UIControlEventTouchDownRepeat];
		[button addTarget:self action:@selector(highlightOn:) forControlEvents:highlightingTouches2];
		[button addTarget:self action:@selector(highlightOff:) forControlEvents:unHighlightingTouches2];
	}
	return button;
}

#pragma mark Public APIs

-(void)setEnabled_:(id)value
{
	[[self button] setEnabled:[TiUtils boolValue:value]];
}

-(void)setBorderRadius_:(id)value
{	
	if (value != nil)
	{
		borderRadius = [TiUtils floatValue:value];
		button.layer.cornerRadius = borderRadius;
	}
}

-(void)setTitle_:(id)value
{
	[[self button] setTitle:[TiUtils stringValue:value] forState:UIControlStateNormal];
}

-(void)setBackgroundColor_:(id)value
{
	if (value!=nil)
	{
		TiColor *color = [TiUtils colorValue:value];
		[[self button]  setBackgroundColor:[color _color]];
	}
}

-(void)setFont_:(id)font
{
	if (font!=nil)
	{
		WebFont *f = [TiUtils fontValue:font def:nil];
		[[[self button] titleLabel] setFont:[f font]];
	}
}

-(void)setColor_:(id)color
{
	if (color!=nil)
	{
		TiColor *c = [TiUtils colorValue:color];
		UIButton *b = [self button];
		if (c!=nil)
		{
			[b setTitleColor:[c _color] forState:UIControlStateNormal];
		}
		else if (b.buttonType==UIButtonTypeCustom)
		{
			[b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		}
	}
}

-(void)setSelectedColor_:(id)color
{
	if (color != nil)
	{
		TiColor *selColor = [TiUtils colorValue:color];
		UIButton *b = [self button];
		if (selColor!=nil)
		{
			[b setTitleColor:[selColor _color] forState:UIControlStateHighlighted];
		}
		else if (b.buttonType==UIButtonTypeCustom)
		{
			[b setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		}
	}
}

-(void)setTextAlign_:(id)align
{
	UIButton *b = [self button];
	if ([align isEqual:@"left"])
	{
		b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		b.contentEdgeInsets = UIEdgeInsetsMake(0,10,0,0);
	}
	else if ([align isEqual:@"right"])
	{
		b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
		b.contentEdgeInsets = UIEdgeInsetsMake(0,0,10,0);
	}
	else if ([align isEqual:@"center"])
	{
		b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	}
}

-(CGFloat)autoWidthForWidth:(CGFloat)value
{
	return [[self button] sizeThatFits:CGSizeMake(value, 0)].width;
}

-(CGFloat)autoHeightForWidth:(CGFloat)value
{
	return [[self button] sizeThatFits:CGSizeMake(value, 0)].height;
}

/*
-(void)setStyle_:(id)style_
{
	int s = [TiUtils intValue:style_ def:UIButtonTypeCustom];
	if (s == style)
	{
		return;
	}
	style = s;
	
	
	if (button==nil)
	{
		return;
	}
	
	RELEASE_TO_NIL(button);
	[self button];
}

-(void)setImage_:(id)value
{
	UIImage *image = value==nil ? nil : [TiUtils image:value proxy:(TiProxy*)self.proxy];
	if (image!=nil)
	{
		[[self button] setImage:image forState:UIControlStateNormal];
		
		// if the layout is undefined or auto, we need to take the size of the image
		//TODO: Refactor. This will cause problems if there's multiple setImages called,
		//Since we change the values of the proxy.
		LayoutConstraint *layout = [(TiViewProxy *)[self proxy] layoutProperties];
		BOOL reposition = NO;
		
		if (TiDimensionIsUndefined(layout->width) || TiDimensionIsAuto(layout->width))
		{
			layout->width.value = image.size.width;
			layout->width.type = TiDimensionTypePixels;
			reposition = YES;
		}
		if (TiDimensionIsUndefined(layout->height) || TiDimensionIsAuto(layout->height))
		{
			layout->height.value = image.size.height;
			layout->height.type = TiDimensionTypePixels;
		}
		if (reposition)
		{
			[(TiViewProxy *)[self proxy] contentsWillChange];			
		}
	}
	else
	{
		[[self button] setImage:nil forState:UIControlStateNormal];
	}
}

-(void)setBackgroundImage_:(id)value
{
	[[self button] setBackgroundImage:[self loadImage:value] forState:UIControlStateNormal];
    self.backgroundImage = value;
}

-(void)setBackgroundSelectedImage_:(id)value
{
	[[self button] setBackgroundImage:[self loadImage:value] forState:UIControlStateHighlighted];
}

-(void)setBackgroundDisabledImage_:(id)value
{
	[[self button] setBackgroundImage:[self loadImage:value] forState:UIControlStateDisabled];
}
*/

@end