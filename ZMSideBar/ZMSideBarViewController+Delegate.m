//
//  ZMSideBarViewController+Delegate.m
//  ZMSideBar
//
//  Created by Yuri Boyka on 2019/1/12.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMSideBarViewController+Delegate.h"
#import "ZMSideBarViewController+DataSource.h"
#import "ZMSideBarCellView.h"

@implementation ZMSideBarViewController (Delegate)
- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item { return [self isSourceGroupItem:item]; }
- (BOOL)outlineView:(NSOutlineView *)outlineView shouldShowOutlineCellForItem:(id)item
{
    if ([item isKindOfClass:[Section class]])
    {
        if (item)
        {
            if ([((Section *)item).name isEqualToString:@"Account2"])
            {
                return NO;
            }
            else
            {
                return YES;
            }
        }
    }
    return YES;
}

- (nullable NSView *)outlineView:(NSOutlineView *)outlineView
              viewForTableColumn:(nullable NSTableColumn *)tableColumn
                            item:(id)item
{
    if ([item isKindOfClass:[Section class]])
    {
        ZMHeaderCellView *cell = [outlineView makeViewWithIdentifier:@"FeedCellHeader" owner:self];
        cell.fillColor = self.backgroundColor;
        cell.textField.stringValue = ((Section *)item).name.uppercaseString;
        cell.imageView.image = ((Section *)item).icon;
        return cell;
    }
    else if ([item isKindOfClass:[Account class]])
    {
        ZMSideBarCellView *cell = [outlineView makeViewWithIdentifier:@"FeedCell" owner:self];
        cell.imageView.image = ((Account *)item).icon;

        NSMutableDictionary *attribut = [NSMutableDictionary new];
        attribut[NSForegroundColorAttributeName] = [NSColor redColor];
        attribut[NSFontAttributeName] = [NSFont boldSystemFontOfSize:12.0];
        NSMutableAttributedString *attributText =
            [[NSMutableAttributedString alloc] initWithString:((Account *)item).name];
        [attributText setAttributes:attribut range:NSMakeRange(0, attributText.length)];

        cell.textField.delegate = self;
        cell.textField.attributedStringValue = attributText;
        cell.textField.textColor = self.textColor;

        [cell.button setHidden:((Account *)item).isHidden];
        cell.title = ((Account *)item).badge;
        cell.backgroundColor = (__bridge NSColor * _Nonnull)(((Account *)item).badgeColor.CGColor);

        cell.button.bezelStyle = NSBezelStyleInline;
        cell.needsDisplay = YES;
        return cell;
    }
    return nil;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
    if (![notification.object isKindOfClass:[NSOutlineView class]]) return;
    NSOutlineView *outlineView = (NSOutlineView *)notification.object;
    NSInteger selectedIndex = outlineView.selectedRow;
    id item = [outlineView itemAtRow:selectedIndex];
    if ([item isKindOfClass:[Account class]])
    {
        [self.delegate changeView:item];
    }
}

@end
