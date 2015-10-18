#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ALManagedObjectFactory : NSObject

// dependencies
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Class entityDescriptionClass;

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext*)context;

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext*)context
                   andEntityDescriptionClass:(__unsafe_unretained Class)entityDescriptionClass;

- (NSManagedObject*)createObjectForEntityClass:(__unsafe_unretained Class)entityClass;

- (NSManagedObject*)createObjectForEntityName:(NSString*)entityName;

@end

@interface ALManagedObjectFactory (Singleton)

+ (ALManagedObjectFactory*)defaultFactory;

@end
