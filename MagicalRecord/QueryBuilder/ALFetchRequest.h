//
//  ALFetchRequest.h
//  Pods
//
//  Created by Aziz U. Latypov on 3/3/15.
//
//

#import <CoreData/CoreData.h>

@interface ALFetchRequest : NSFetchRequest
@property (nonatomic, weak) NSManagedObjectContext *MR_managedObjectContext;
@end
