//
//  Task.m
//  ObjectiveToDo
//
//  Created by Mike Shevelinsky on 03.02.2021.
//

#import "Task.h"

@implementation Task

- (id) initWithName:(NSString *)name
{
    self = [super init];
    if(self)
    {
        self.name = name;
        self.isComplete = FALSE;
    }
    return self;
}

@end
