//
//  ZMSideBarViewController.h
//  ZMSideBar
//
//  Created by Yuri Boyka on 2019/1/12.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZMSideBarData.h"

NS_ASSUME_NONNULL_BEGIN

#define REORDER_PASTEBOARD_TYPE @"com.outline.item"

@protocol ZMSideBarViewDelegate <NSObject>

- (void)changeView:(Account *)item;

@end

@interface ZMSideBarViewController : NSViewController
@property(nonatomic, weak) IBOutlet NSOutlineView *sidebarOutlineView;
@property(nonatomic, weak) IBOutlet NSButton *group;
@property(nonatomic, weak) id<ZMSideBarViewDelegate> delegate;
@property(nonatomic, strong) id draggedNode;
@property(nonatomic, assign) NSInteger fromIndex;
@property(nonatomic, strong) AllSection *allSection;
@property(nonatomic, assign) BOOL allowDragAndDrop;
@property(nonatomic, assign) BOOL saveSection;
@property(nonatomic, strong) NSColor *backgroundColor;
@property(nonatomic, assign) NSTableViewRowSizeStyle rowStyle;
@property(nonatomic, strong) NSColor *textColor;
@property(nonatomic, assign) NSInteger selectIndex;
- (void)save;
@end

NS_ASSUME_NONNULL_END
