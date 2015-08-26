// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to POLNote.h instead.

@import CoreData;

extern const struct POLNoteAttributes {
	__unsafe_unretained NSString *creationDate;
	__unsafe_unretained NSString *modificationDate;
	__unsafe_unretained NSString *text;
	__unsafe_unretained NSString *title;
} POLNoteAttributes;

extern const struct POLNoteRelationships {
	__unsafe_unretained NSString *book;
	__unsafe_unretained NSString *image;
	__unsafe_unretained NSString *location;
} POLNoteRelationships;

@class POLBook;
@class POLImage;
@class POLLocation;

@interface POLNoteID : NSManagedObjectID {}
@end

@interface _POLNote : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) POLNoteID* objectID;

@property (nonatomic, strong) NSDate* creationDate;

//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* modificationDate;

//- (BOOL)validateModificationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) POLBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) POLImage *image;

//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) POLLocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@end

@interface _POLNote (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;

- (NSDate*)primitiveModificationDate;
- (void)setPrimitiveModificationDate:(NSDate*)value;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (POLBook*)primitiveBook;
- (void)setPrimitiveBook:(POLBook*)value;

- (POLImage*)primitiveImage;
- (void)setPrimitiveImage:(POLImage*)value;

- (POLLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(POLLocation*)value;

@end
