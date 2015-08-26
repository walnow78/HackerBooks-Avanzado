// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to POLTag.h instead.

@import CoreData;

extern const struct POLTagAttributes {
	__unsafe_unretained NSString *name;
} POLTagAttributes;

extern const struct POLTagRelationships {
	__unsafe_unretained NSString *book;
} POLTagRelationships;

@class POLBook;

@interface POLTagID : NSManagedObjectID {}
@end

@interface _POLTag : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) POLTagID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *book;

- (NSMutableSet*)bookSet;

@end

@interface _POLTag (BookCoreDataGeneratedAccessors)
- (void)addBook:(NSSet*)value_;
- (void)removeBook:(NSSet*)value_;
- (void)addBookObject:(POLBook*)value_;
- (void)removeBookObject:(POLBook*)value_;

@end

@interface _POLTag (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBook;
- (void)setPrimitiveBook:(NSMutableSet*)value;

@end
