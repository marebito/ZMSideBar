//
//  ZMSideBarViewController.m
//  ZMSideBar
//
//  Created by Yuri Boyka on 2019/1/12.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMSideBarViewController.h"

@interface ZMSideBarViewController ()
{
    NSUserDefaults *defaults;
}
@end

@implementation ZMSideBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
    self.selectIndex = 1;
}

- (void)viewDidAppear
{
    [super viewDidAppear];
    
    if (self.allowDragAndDrop)
    {
        [_sidebarOutlineView registerForDraggedTypes:@[REORDER_PASTEBOARD_TYPE]];
        [_sidebarOutlineView setDraggingSourceOperationMask:NSDragOperationNone forLocal:NO];
        [_sidebarOutlineView setDraggingSourceOperationMask:NSDragOperationEvery forLocal:YES];
    }
    
    _sidebarOutlineView.rowSizeStyle = self.rowStyle;
    
    NSInteger index = [_sidebarOutlineView rowForItem:[_sidebarOutlineView itemAtRow:1]];
    [_sidebarOutlineView scrollRowToVisible:index];
    [_sidebarOutlineView selectRowIndexes:[NSIndexSet indexSetWithIndex:self.selectIndex] byExtendingSelection:NO];
}

- (void)initData:(AllSection *)allSection
{
    self.allSection = allSection;
}

- (void)reloadData
{
    [_sidebarOutlineView sizeLastColumnToFit];
    [_sidebarOutlineView reloadData];
    _sidebarOutlineView.floatsGroupRows = NO;
    
    _sidebarOutlineView.rowSizeStyle = self.rowStyle;
    [_sidebarOutlineView expandItem:nil expandChildren:YES];
    [_sidebarOutlineView selectRowIndexes:[NSIndexSet indexSetWithIndex:self.selectIndex] byExtendingSelection:NO];
}

- (void)save
{
    for (Section *section in self.allSection.sections)
    {
        NSMutableArray *account = section.accounts;
        NSString *name = section.name;
        
        NSData *archiver = [NSKeyedArchiver archivedDataWithRootObject:account requiringSecureCoding:NO error:nil];
        [defaults setObject:archiver forKey:name];
    }
    [defaults synchronize];
}

- (BOOL)load:(AllSection *)allSection
{
    self.allSection = allSection;
    
    for (Section *section in allSection.sections) {
        NSString *name = section.name;
        NSData *retrievedData = [defaults objectForKey:name];
        if (!retrievedData) {
            NSError *error = nil;
            NSArray *accounts = [NSKeyedUnarchiver unarchivedObjectOfClass:[Account class] fromData:retrievedData error:&error];
            for (Account *account in accounts)
            {
                [section.accounts addObject:account];
            }
        }
        else
        {
            return NO;
        }
    }
    return YES;
}

@end
