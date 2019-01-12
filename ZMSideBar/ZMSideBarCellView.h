//
//  ZMSideBarCellView.h
//  ZMSideBar
//
//  Created by Yuri Boyka on 2019/1/12.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMHeaderCellView : NSTableCellView
@property(nonatomic, strong) NSColor *fillColor;
@end

@interface ZMSideBarCellView : NSTableCellView
@property(nonatomic, strong) NSMutableDictionary *attribut;
@property(nonatomic, strong) NSColor *backgroundColor;
@property(nonatomic, assign) CGFloat cornerRadius;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) NSColor *foregroundColor;
@property(nonatomic, strong) NSFont *font;
@property(nonatomic, weak) NSButton *button;
@end

NS_ASSUME_NONNULL_END
