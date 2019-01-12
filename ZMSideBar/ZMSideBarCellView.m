//
//  ZMSideBarCellView.m
//  ZMSideBar
//
//  Created by Yuri Boyka on 2019/1/12.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMSideBarCellView.h"

@implementation ZMHeaderCellView

- (instancetype)init
{
    if (self = [super init])
    {
        _fillColor = [NSColor colorWithRed:249.0/255.0 green:217.0/255.0 blue:140.0/255.0 alpha:1.0];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    NSBezierPath *bPath = [NSBezierPath bezierPathWithRect:dirtyRect];
    [_fillColor set];
    [bPath fill];
    
}

@end

@implementation ZMSideBarCellView

- (instancetype)init
{
    if (self = [super init]) {
        _attribut = [NSMutableDictionary new];
        _backgroundColor = [NSColor greenColor];
        _cornerRadius = 8.0;
        _title = @"0";
        _foregroundColor = [NSColor whiteColor];
        _font = [NSFont fontWithName:@"Avenir" size:10.0];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

- (void)viewWillDraw
{
    [super viewWillDraw];
    if (!_button.isHidden)
    {
        _button.wantsLayer = YES;
        _button.layer.backgroundColor = _backgroundColor.CGColor;
        _button.layer.cornerRadius = _cornerRadius;
        
        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
        paragraph.alignment = NSTextAlignmentCenter;
        _attribut[NSFontAttributeName] = _font;
        _attribut[NSParagraphStyleAttributeName] = paragraph;
        _attribut[NSForegroundColorAttributeName] = _foregroundColor;
        
        NSMutableAttributedString *attributText = [[NSMutableAttributedString alloc] initWithString:_title];
        [attributText setAttributes:_attribut range:NSMakeRange(0, attributText.length)];
        _button.attributedTitle = attributText;
        
        [_button sizeToFit];
        NSRect buttonFrame = _button.frame;
        _button.frame = buttonFrame;
    }
}

@end
