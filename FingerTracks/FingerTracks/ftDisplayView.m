//
//  ftDisplayView.m
//  FingerTracks
//
//  Created by Joe Andolina on 2/7/13.
//  Copyright (c) 2013 Joe Andolina. All rights reserved.
//

#import "ftDisplayView.h"
#import "ftDisplayPoint.h"


@implementation ftDisplayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDisplay];
    }
    return self;
}


// Used for storyboard instantiation
-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initDisplay];
    }
    return self;
}


-(void)initDisplay
{
    self.opaque = NO;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    
    _fillColor      = [UIColor colorWithWhite:0 alpha:0.5f];
    _outlineColor   = [UIColor clearColor];
}

-(void)decayTouches
{
    for (UIView *subview in self.subviews)
    {
        [subview removeFromSuperview];
    }
}


- (void)updateTouches:(NSSet *)touches
{
    BOOL allDone = YES;
    
    [self decayTouches];
    
    for (UITouch *touch in touches)
    {
        if( touch.phase == UITouchPhaseBegan || touch.phase == UITouchPhaseMoved || touch.phase == UITouchPhaseStationary )
        {
            [self showTouch:touch];
            allDone = NO;
        }
    }
    
    if( allDone == YES)
    {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
}


- (void)showTouch:(UITouch *)touch
{
    if(touch.phase == UITouchPhaseBegan || touch.phase == UITouchPhaseMoved)
    {
        CGPoint touchPoint = [touch locationInView:self];
        
        ftDisplayPoint *fp = [[ftDisplayPoint alloc] initWithPoint:CGPointMake(touchPoint.x, touchPoint.y)
                                                       fillColor:_fillColor
                                                    outlineColor:_outlineColor];
        [self addSubview:fp];
    }
}

@end
