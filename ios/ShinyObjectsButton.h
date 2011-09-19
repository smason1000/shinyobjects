// View class for button module

#import "TiUIView.h" 

@interface ShinyObjectsButton : TiUIView
{
@private
	UIButton 		*button;
	float			borderRadius;
    CAGradientLayer *shineLayer;
    CALayer         *highlightLayer;
	int 			style;
	
	BOOL eventAlreadyTriggered;
}

- (UIButton*)button;
- (void)setEnabled_:(id)value;
- (void)initLayers;
- (void)initBorder;
- (void)addShineLayer;
- (void)addHighlightLayer;

@end