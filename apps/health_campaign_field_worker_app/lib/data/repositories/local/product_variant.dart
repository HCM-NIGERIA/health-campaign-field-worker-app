import 'dart:async';

import 'package:drift/drift.dart';

import '../../../models/data_model.dart';
import '../../../utils/utils.dart';
import '../../data_repository.dart';

class ProductVariantLocalRepository
    extends LocalRepository<ProductVariantModel, ProductVariantSearchModel> {
  ProductVariantLocalRepository(super.sql, super.opLogManager);

  @override
  FutureOr<List<ProductVariantModel>> search(
    ProductVariantSearchModel query,
  ) async {
    return retryLocalCallOperation(() async {
      final selectQuery = sql.select(sql.productVariant).join([]);

      final results = await (selectQuery
            ..where(buildAnd([
              if (query.id != null) sql.productVariant.id.isIn(query.id!),
              if (query.productId != null)
                sql.productVariant.productId.equals(query.productId!),
            ])))
          .get();

      return results.map((e) {
        final productVariant = e.readTable(sql.productVariant);

        return ProductVariantModel(
          tenantId: productVariant.tenantId,
          isDeleted: productVariant.isDeleted,
          id: productVariant.id,
          rowVersion: productVariant.rowVersion,
          productId: productVariant.productId,
          sku: productVariant.sku,
          variation: productVariant.variation,
        );
      }).toList();
    });
  }

  @override
  FutureOr<void> create(
    ProductVariantModel entity, {
    bool createOpLog = false,
    DataOperation dataOperation = DataOperation.create,
  }) async {
    return retryLocalCallOperation(() async {
      await sql.batch((batch) async {
        batch.insert(
          sql.productVariant,
          entity.companion,
          mode: InsertMode.insertOrReplace,
        );
      });

      await super.create(
        entity,
        createOpLog: createOpLog,
      );
    });
  }

  @override
  DataModelType get type => DataModelType.productVariant;
}
