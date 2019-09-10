//
//  ViewController.m
//  LNPropertyListEditorExample
//
//  Created by Leo Natan (Wix) on 4/12/18.
//  Copyright © 2018 Leo Natan. All rights reserved.
//

#import "ViewController.h"
#import <LNPropertyListEditor/LNPropertyListEditor.h>

@interface ViewController () <LNPropertyListEditorDelegate> @end

@implementation ViewController
{
	IBOutlet LNPropertyListEditor* _plistEditor;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	NSURL* propertyListURL = [[NSBundle mainBundle].bundleURL URLByAppendingPathComponent:@"Contents/Info.plist"];
	id obj = [NSPropertyListSerialization propertyListWithData:[NSData dataWithContentsOfURL:propertyListURL] options:0 format:nil error:NULL];
	
	_plistEditor.delegate = self;
	
	_plistEditor.propertyList = obj;
    
    //Example for adding custom menu items
    [_plistEditor addSeparatorMenuItem];
    [_plistEditor addCustomMenuItemWithTitle:@"TETS" keyEquvalent:nil withActionBlock:^(LNPropertyListNode *node) {
        NSLog(@"Node: %@",node.key);
    }];
}

- (void)didTapCustomAcitonForNode:(LNPropertyListNode*)node{
    NSLog(@"Node: %@",node.key);
}

#pragma mark LNPropertyListEditorDelegate

- (void)propertyListEditor:(LNPropertyListEditor *)editor willChangeNode:(LNPropertyListNode *)node changeType:(LNPropertyListNodeChangeType)changeType previousKey:(NSString *)previousKey
{
	switch(changeType)
	{
		case LNPropertyListNodeChangeTypeMove:
			NSLog(@"➡️");
			break;
		case LNPropertyListNodeChangeTypeInsert:
			NSLog(@"🎉");
			break;
		case LNPropertyListNodeChangeTypeDelete:
			NSLog(@"🗑");
			break;
		case LNPropertyListNodeChangeTypeUpdate:
			NSLog(@"🔄");
			break;
	}
	
	NSLog(@"%@", [editor.rootPropertyListNode childNodeContainingDescendantNode:node]);
}

@end
