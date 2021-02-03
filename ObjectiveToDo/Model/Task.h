//
//  Task.h
//  ObjectiveToDo
//
//  Created by Mike Shevelinsky on 03.02.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject

@property (nonatomic, strong) NSString *name;
@property (assign) BOOL isComplete;

- (id) initWithName: (NSString*)name;

@end

NS_ASSUME_NONNULL_END
