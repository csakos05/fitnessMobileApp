import 'package:cloud_firestore/cloud_firestore.dart';

/// An abstract repository providing basic CRUD operations for a Firestore collection.
/// It uses a generic type `T` for the data model.
abstract class BaseFirestoreRepository<T> {
  final CollectionReference<T> collection;

  /// Requires the collection path and functions for JSON conversion.
  BaseFirestoreRepository(
    String collectionPath,
    T Function(Map<String, dynamic> json) fromJson,
    Map<String, dynamic> Function(T model) toJson,
  ) : collection =
            FirebaseFirestore.instance.collection(collectionPath).withConverter<T>(
                  fromFirestore: (snapshot, _) => fromJson(snapshot.data()!),
                  toFirestore: (model, _) => toJson(model),
                );

  /// Creates or overwrites a document with a specific ID.
  Future<void> create(String id, T data) async {
    await collection.doc(id).set(data);
  }

  /// Reads a single document by its ID.
  Future<T?> read(String id) async {
    final doc = await collection.doc(id).get();
    return doc.data();
  }

  /// Updates a document with new data.
  Future<void> update(String id, Map<String, dynamic> data) async {
    await collection.doc(id).update(data);
  }

  /// Deletes a document by its ID.
  Future<void> delete(String id) async {
    await collection.doc(id).delete();
  }

  /// Reads all documents from the collection.
  Future<List<T>> readAll() async {
    final snapshot = await collection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}