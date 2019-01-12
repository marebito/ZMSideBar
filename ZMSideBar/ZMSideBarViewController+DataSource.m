//
//  ZMSideBarViewController+DataSource.m
//  ZMSideBar
//
//  Created by Yuri Boyka on 2019/1/12.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMSideBarViewController+DataSource.h"

@implementation ZMSideBarViewController (DataSource)

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    if (item)
    {
        if ([item isKindOfClass:[Section class]])
        {
            return ((Section *)item).accounts.count;
        }
        return 0;
    }
    return self.allSection.sections.count;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    if (item)
    {
        if ([item isKindOfClass:[Section class]])
        {
            return ((Section *)item).accounts[index];
        }
        return 0;
    }
    return self.allSection.sections[index];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item
{
    return ![self isSourceGroupItem:item];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    if ([item isKindOfClass:[Section class]]) {
        return (((Section *)item).accounts.count > 0);
    }
    return NO;
}

- (nullable id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn byItem:(nullable id)item
{
    if ([item isKindOfClass:[Section class]]) {
        return item;
    }
    if ([item isKindOfClass:[Account class]]) {
        return item;
    }
    return nil;
}

- (BOOL)isSourceGroupItem:(id)item
{
    if ([item isKindOfClass:[Section class]])
    {
        return YES;
    }
    return NO;
}

@end
