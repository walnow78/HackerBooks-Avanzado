// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to POLAuthor.h instead.

@import CoreData;

extern const struct POLAuthorAttributes {
	__unsafe_unretained NSString *name;
} POLAuthorAttributes;

extern const struct POLAuthorRelationships {
	__unsafe_unretained NSString *book;
} POLAuthorRelationships;

@class POLBook;

@interface POLAuthorID : NSManagedObjectID {}
@end

@interface _POLAuthor : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) POLAuthorID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *book;

- (NSMutableSet*)bookSet;

@end

@interface _POLAuthor (BookCoreDataGeneratedAccessors)
- (void)addBook:(NSSet*)value_;
- (void)removeBook:(NSSet*)value_;
- (void)addBookObject:(POLBook*)value_;
- (void)removeBookObject:(POLBook*)value_;

@end

@interface _POLAuthor (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBook;
- (void)setPrimitiveBook:(NSMutableSet*)value;

@end
