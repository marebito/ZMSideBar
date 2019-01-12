//
//  ZMSideBarViewController+DrageDrop.m
//  ZMSideBar
//
//  Created by Yuri Boyka on 2019/1/12.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMSideBarViewController+DrageDrop.h"

@implementation ZMSideBarViewController (DrageDrop)

- (id<NSPasteboardWriting>)outlineView:(NSOutlineView *)outlineView pasteboardWriterForItem:(id)item
{
    NSPasteboardItem *pbItem = [NSPasteboardItem new];
    [pbItem setDataProvider:self forTypes:@[REORDER_PASTEBOARD_TYPE]];
    return pbItem;
}

- (void)outlineView:(NSOutlineView *)outlineView draggingSession:(NSDraggingSession *)session willBeginAtPoint:(NSPoint)screenPoint forItems:(NSArray *)draggedItems
{
    self.draggedNode = draggedItems[0];
    [session.draggingPasteboard setData:[NSData data] forType:REORDER_PASTEBOARD_TYPE];
    NSLog(@"Drag session begin");
}

- (void)outlineView:(NSOutlineView *)outlineView draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation
{
    NSLog(@"Drag session ended");
    self.draggedNode = nil;
    if (self.saveSection) {
        [self save];
    }
}

- (NSDragOperation)outlineView:(NSOutlineView *)outlineView validateDrop:(id <NSDraggingInfo>)info proposedItem:(nullable id)item proposedChildIndex:(NSInteger)index
{
    NSDragOperation retVal = NSDragOperationNone;
    NSString *itemName = @"nilItem";
    if (item && [item isKindOfClass:[Account class]])
    {
        itemName = ((Account *)item).name;
    }
    if (item == self.draggedNode && index != NSOutlineViewDropOnItemIndex)
    {
        if ([self.draggedNode isKindOfClass:[Section class]])
        {
            if (!item) {
                retVal = NSDragOperationGeneric;
            }
        }
        else if ([self.draggedNode isKindOfClass:[Account class]])
        {
            retVal = NSDragOperationGeneric;
        }
        NSLog(@"validateDrop targetItem: \(itemName) childIndex: \(index) returning: \(retVal != NSDragOperation())");
    }
    return retVal;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView acceptDrop:(id <NSDraggingInfo>)info item:(nullable id)item childIndex:(NSInteger)index
{
    BOOL retVal = NO;
    if ([self.draggedNode isKindOfClass:[BaseItem class]]) {
        return NO;
    }
    
    BaseItem *srcItem = self.draggedNode;
    Section *destItem = item;
    Section *parentItem = [outlineView parentForItem:srcItem];
    NSInteger oldIndex = [outlineView childIndexForItem:srcItem];
    NSInteger toIndex = index;
    
    if (!destItem) {
        return NO;
    }
    
    NSLog(@"move src:\(srcItem.name) dest:\(String(describing: (destItem?.name)!)) destIndex:\(index) oldIndex:\(oldIndex) srcParent:\(String(describing: (parentItem?.name)!)) toIndex:\(toIndex) toParent:\(String(describing: (destItem?.name)!)) childIndex:\(index)");
    
    if (toIndex == NSOutlineViewDropOnItemIndex) {
        toIndex = 0;
    }
    else
    {
        toIndex -= 1;
    }
    
    if ([srcItem isKindOfClass:[Section class]] && destItem) {
        retVal = NO;
    }
    else if(oldIndex != toIndex || parentItem != destItem)
    {
        [self.allSection moveItemAtIndex:oldIndex inParent:parentItem toIndex:toIndex inParent:destItem];
        [outlineView moveItemAtIndex:oldIndex inParent:parentItem toIndex:toIndex inParent:destItem];
        retVal = YES;
    }
    NSLog(@" returning:\(retVal)");
    if (retVal) {
        [self.allSection dump];
    }
    return retVal;
}

- (void)pasteboard:(NSPasteboard *)pasteboard item:(NSPasteboardItem *)item provideDataForType:(NSPasteboardType)type
{
    NSString *s = @"Outline Pasteboard Item";
    [item setString:s forType:type];
}
@end
