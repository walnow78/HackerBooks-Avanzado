// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to POLPDF.h instead.

@import CoreData;

extern const struct POLPDFAttributes {
	__unsafe_unretained NSString *file;
} POLPDFAttributes;

extern const struct POLPDFRelationships {
	__unsafe_unretained NSString *book;
} POLPDFRelationships;

@class POLBook;

@interface POLPDFID : NSManagedObjectID {}
@end

@interface _POLPDF : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) POLPDFID* objectID;

@property (nonatomic, strong) NSData* file;

//- (BOOL)validateFile:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) POLBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _POLPDF (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveFile;
- (void)setPrimitiveFile:(NSData*)value;

- (POLBook*)primitiveBook;
- (void)setPrimitiveBook:(POLBook*)value;

@end
