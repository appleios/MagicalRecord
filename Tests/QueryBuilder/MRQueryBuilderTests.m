//
//  MRQueryBuilderTests.m
//  MagicalRecord
//
//  Created by Aziz Latypov on 18/10/15.
//  Copyright © 2015 Magical Panda Software LLC. All rights reserved.
//

#import "MagicalRecordTestBase.h"
#import "SingleEntityWithNoRelationships.h"

#import <MagicalRecord/MagicalRecord.h>

@interface QueryBuilderTests : MagicalRecordTestBase

@end

@implementation QueryBuilderTests

#pragma mark - 

//- (void)testSaveToSelfOnlyWhenSaveIsSynchronous
//{
//    NSManagedObjectContext *parentContext = [NSManagedObjectContext MR_defaultContext];
//    NSManagedObjectContext *childContext = [NSManagedObjectContext MR_contextWithParent:parentContext];
//    
//    XCTestExpectation *childContextSavedExpectation = [self expectationWithDescription:@"Child Context Did Save"];
//    
//    __block NSManagedObjectID *insertedObjectID;
//    
//    [childContext performBlockAndWait:^{
//        SingleEntityWithNoRelationships *insertedObject = [SingleEntityWithNoRelationships MR_createEntityInContext:childContext];
//        
//        expect([insertedObject hasChanges]).to.beTruthy();
//        
//        NSError *obtainIDsError;
//        BOOL obtainIDsResult = [childContext obtainPermanentIDsForObjects:@[insertedObject] error:&obtainIDsError];
//        
//        expect(obtainIDsResult).to.beTruthy();
//        expect(obtainIDsError).to.beNil();
//        
//        insertedObjectID = [insertedObject objectID];
//        
//        expect(insertedObjectID).toNot.beNil();
//        expect([insertedObjectID isTemporaryID]).to.beFalsy();
//        
//        [childContext MR_saveOnlySelfAndWait];
//        
//        [childContextSavedExpectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0f handler:nil];
//    
//    XCTestExpectation *parentContextSavedExpectation = [self expectationWithDescription:@"Parent Context Did Save"];
//    childContextSavedExpectation = [self expectationWithDescription:@"Child Context Did Save"];
//    
//    [parentContext performBlockAndWait:^{
//        NSManagedObject *parentContextFetchedObject = [parentContext objectRegisteredForID:insertedObjectID];
//        
//        // Saving a child context moves the saved changes up to the parent, but does
//        //  not save them, leaving the parent context with changes
//        expect(parentContextFetchedObject).toNot.beNil();
//        expect([parentContextFetchedObject hasChanges]).to.beTruthy();
//        
//        [childContext performBlockAndWait:^{
//            NSManagedObject *childContextFetchedObject = [childContext objectRegisteredForID:insertedObjectID];
//            
//            // The child context should not have changes after the save
//            expect(childContextFetchedObject).toNot.beNil();
//            expect([childContextFetchedObject hasChanges]).to.beFalsy();
//            
//            [childContextSavedExpectation fulfill];
//        }];
//        
//        [parentContextSavedExpectation fulfill];
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0f handler:nil];
//}



//describe(@"default managed object context", ^{
//    it(@"should not be nil", ^{
//        expect([ALCoreDataManager defaultManager].managedObjectContext).notTo.beNil();
//    });
//});
//
//describe(@"in memory store", ^{
//    
//    __block ALCoreDataManager *manager;
//    __block NSManagedObjectContext *context;
//    __block ALManagedObjectFactory *factory;
//    
//    Product*(^item)(NSString *title, NSNumber *price, NSNumber *amount) =
//    ^(NSString *title, NSNumber *price, NSNumber *amount)
//    {
//        NSPredicate *predicate =
//        [NSPredicate predicateWithFormat:@"title = %@ && price = %@ && amount = %@",title,price,amount];
//        NSArray *items =
//        [[[[Product allInManagedObjectContext:context] where:predicate] limit:1] execute];
//        
//        Product *a = [items firstObject];
//        return a;
//    };
//    
//    
//    beforeAll(^{
//        manager = [[ALCoreDataManager alloc] initWithInMemoryStore];
//        context = manager.managedObjectContext;
//        factory = [[ALManagedObjectFactory alloc] initWithManagedObjectContext:context];
//    });
//    
//    it(@"should create item without dictionary", ^{
//        [factory createObjectForEntityName:@"Product"];
//        
//        Product *a = (Product*)[Product createWithFields:nil
//                                            usingFactory:factory];
//        
//        expect(a).notTo.beNil;
//    });
//    
//    
//    it(@"should create item", ^{
//        [factory createObjectForEntityName:@"Product"];
//        
//        Product *a = (Product*)[Product createWithFields:@{
//                                                           @"title" : @"A",
//                                                           @"price" : @(175),
//                                                           @"amount" : @(10)
//                                                           }
//                                            usingFactory:factory];
//        
//        expect(a).notTo.beNil;
//        expect([a valueForKey:@"title"]).equal(@"A");
//        expect([a valueForKey:@"price"]).equal(@(175));
//        expect([a valueForKey:@"amount"]).equal(@(10));
//        
//    });
//    
//    it(@"should be fetched", ^{
//        
//        Product *a = item(@"A",@(175),@(10));
//        
//        expect(a).notTo.beNil;
//        expect(a.title).to.equal(@"A");
//        expect(a.price).to.equal(@(175));
//        expect(a.amount).to.equal(@(10));
//    });
//    
//    it(@"should be update", ^{
//        Product *a = item(@"A",@(175),@(10));
//        
//        a.title = @"B";
//        a.price = @(120);
//        a.amount = @(160);
//        
//        expect(a).notTo.beNil;
//        expect(a.title).to.equal(@"B");
//        expect(a.price).to.equal(@(120));
//        expect(a.amount).to.equal(@(160));
//        
//    });
//    
//    it(@"should be remove",^{
//        Product *a = item(@"B",@(120),@(160));
//        
//        [a remove];
//        expect(a.deleted).to.beTruthy;
//    });
//    
//    afterAll(^{
//        manager = nil;
//        context = nil;
//        factory = nil;
//    });
//    
//});
//
//describe(@"query builder", ^{
//    
//    __block ALCoreDataManager *manager;
//    __block NSManagedObjectContext *context;
//    __block ALManagedObjectFactory *factory;
//    
//    beforeAll(^{
//        
//        manager = [ALCoreDataManager defaultManager];
//        context = manager.managedObjectContext;
//        factory = [[ALManagedObjectFactory alloc] initWithManagedObjectContext:context];
//        
//        NSArray *existingItems = [[Product allInManagedObjectContext:context] execute];
//        for(Product *a in existingItems){
//            [a remove];
//        }
//        
//        [context save:NULL];
//        
//        // populate
//        int i;
//        
//        for(i=0; i<18; i++){
//            Product *a = (Product*)[Product createWithFields:nil
//                                                usingFactory:factory];
//            
//            a.title = [NSString stringWithFormat:@"%c",'A'+i];
//            a.price = @(144 + (rand()%64));
//            a.amount = @(8 + (rand()%32));
//        }
//        
//        Product *a = (Product*)[Product createWithFields:nil
//                                            usingFactory:factory];
//        
//        a.title = [NSString stringWithFormat:@"%c",'a'];
//        a.price = @(200);
//        a.amount = @(10);
//        
//        Product *b = (Product*)[Product createWithFields:nil
//                                            usingFactory:factory];
//        
//        b.title = [NSString stringWithFormat:@"%c",'Z'];
//        b.price = @(100);
//        b.amount = @(10);
//        
//        [context save:NULL];
//    });
//    
//    it(@"should fetch all", ^{
//        NSArray *items = [[Product allInManagedObjectContext:context] execute];
//        
//        expect(items.count).equal(20);
//    });
//    
//    it(@"should filter", ^{
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = 'B'"];
//        NSArray *items = [[[Product allInManagedObjectContext:context] where:predicate] execute];
//        
//        expect(items.count).equal(1);
//    });
//    
//    it(@"should sort", ^{
//        NSArray *items = [[[Product allInManagedObjectContext:context] orderedBy:@[@"title"]] execute];
//        
//        BOOL isSorted = YES;
//        int i;
//        Product *a = [items firstObject];
//        for(i=1; i<items.count; i++){
//            Product *b = [items objectAtIndex:i];
//            NSComparisonResult r = [b.title compare:a.title];
//            if(r == NSOrderedAscending){
//                isSorted = NO;
//                break;
//            }
//            a = b;
//        }
//        
//        expect(isSorted).equal(YES);
//    });
//    
//    it(@"should count all", ^{
//        NSArray *items = [[[Product allInManagedObjectContext:context] count] execute];
//        NSNumber *count = items.firstObject;
//        
//        expect(count.integerValue).equal(20);
//    });
//    
//    it(@"should count with predicate", ^{
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = 'B'"];
//        NSArray *items = [[[[Product allInManagedObjectContext:context] where:predicate] count] execute];
//        NSNumber *count = items.firstObject;
//        
//        expect(count.integerValue).equal(1);
//    });
//    
//    it(@"should limit", ^{
//        NSArray *items = [[[Product allInManagedObjectContext:context] limit:10] execute];
//        
//        expect(items.count).equal(10);
//    });
//    
//    it(@"should return only distinct", ^{
//        NSString *key = @"amount";
//        NSArray *items = [[[[Product allInManagedObjectContext:context] properties:@[key]] distinct] execute];
//        
//        BOOL onlyDistinct = YES;
//        Product *a = nil;
//        NSMutableSet* set = [NSMutableSet new];
//        
//        for(Product *b in items){
//            if(a){
//                if([set containsObject:[b valueForKey:key]]){
//                    onlyDistinct = NO;
//                    break;
//                }
//            }
//            a = b;
//            [set addObject:[a valueForKey:key]];
//        }
//        
//        expect(items.count).to.beGreaterThan(0);
//        expect(items.count).to.beLessThan(20);
//        expect(onlyDistinct).equal(YES);
//    });
//    
//    it(@"should aggregate", ^{
//        NSArray *items = [[[[[Product allInManagedObjectContext:context
//                              ] aggregatedBy:@[@[kAggregatorMax,@"price"]]
//                             ] groupedBy:@[@"amount"]
//                            ] having:[NSPredicate predicateWithFormat:@"amount >= 10"]
//                           ] execute];
//        
//        double maxPrice = -1;
//        for(NSDictionary *d in items){
//            double x = [[d valueForKey:@"maxPrice"] doubleValue];
//            if(x>maxPrice){
//                maxPrice = x;
//            }
//        }
//        
//        expect(maxPrice).equal(200.f);
//    });
//    
//    afterAll(^{
//        manager = nil;
//        context = nil;
//        factory = nil;
//    });
//});
//


@end
