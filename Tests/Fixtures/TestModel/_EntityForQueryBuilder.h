//
//  _EntityForQueryBuilder.h
//  MagicalRecord
//
//  Created by Aziz Latypov on 18/10/15.
//  Copyright © 2015 Magical Panda Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#else
#import <Cocoa/Cocoa.h>
#endif

extern const struct EntityForQueryBuilderAttributes {
    __unsafe_unretained NSString *titleAttribute;
    __unsafe_unretained NSString *priceAttribute;
    __unsafe_unretained NSString *amountAttribute;
    __unsafe_unretained NSString *countryAttribute;
} EntityForQueryBuilderAttributes;

@interface EntityForQueryBuilderID : NSManagedObjectID {}
@end

@interface _EntityForQueryBuilder : NSManagedObject {}

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EntityForQueryBuilderID*)objectID;

@property (nonatomic, strong) NSString* titleAttribute;

@property (nonatomic, strong) NSNumber* priceAttribute;

@property (nonatomic, strong) NSNumber* amountAttribute;

@property (nonatomic, strong) NSString* contryAttribute;

@end

@interface _EntityForQueryBuilder (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveTitleAttribute;
- (void)setPrimitiveTitleAttribute:(NSString*)value;

- (NSNumber*)primitivePriceAttribute;
- (void)setPrimitivePriceAttribute:(NSNumber*)value;

- (NSNumber*)primitiveAmountAttribute;
- (void)setPrimitiveAmountAttribute:(NSNumber*)value;

- (NSString*)primitiveCountryAttribute;
- (void)setPrimitiveCountryAttribute:(NSString*)value;

@end
