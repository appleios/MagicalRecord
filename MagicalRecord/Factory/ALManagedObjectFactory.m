#import "ALManagedObjectFactory.h"

#import "NSManagedObjectContext+MagicalRecord.h"

@import CoreData;

@implementation ALManagedObjectFactory

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext*)managedObjectContext
{
	if (self = [super init]) {
		self.managedObjectContext = managedObjectContext;
		self.entityDescriptionClass = NSEntityDescription.class;
	}
	return self;
}

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext*)managedObjectContext
                   andEntityDescriptionClass:(__unsafe_unretained Class)entityDescriptionClass
{
    if (self = [super init]) {
        self.managedObjectContext = managedObjectContext;
        self.entityDescriptionClass = entityDescriptionClass;
    }
    return self;
}

- (NSManagedObject*)createObjectForEntityClass:(__unsafe_unretained Class)entityClass
{
    return [self createObjectForEntityName:NSStringFromClass(entityClass)];
}

- (NSManagedObject*)createObjectForEntityName:(NSString*)entityName
{
    //create
    NSManagedObject *product = [self.entityDescriptionClass insertNewObjectForEntityForName:entityName
                                                                     inManagedObjectContext:self.managedObjectContext];
    
    return product;
}

@end

#import "NSManagedObject+MagicalRecord.h"

@implementation ALManagedObjectFactory (Singleton)

+ (ALManagedObjectFactory*)defaultFactory
{
    static ALManagedObjectFactory *factory;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_defaultContext];
        factory =
        [[ALManagedObjectFactory alloc] initWithManagedObjectContext:managedObjectContext
                                           andEntityDescriptionClass:[NSEntityDescription class]];
    });
    return factory;
}

@end
