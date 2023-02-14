import 'dart:async';

import '../../../models/data_model.dart';
import '../../../utils/utils.dart';
import '../../data_repository.dart';

class ProjectBeneficiaryLocalRepository extends LocalRepository<
    ProjectBeneficiaryModel, ProjectBeneficiarySearchModel> {
  ProjectBeneficiaryLocalRepository(super.sql, super.opLogManager);

  @override
  FutureOr<List<ProjectBeneficiaryModel>> search(
    ProjectBeneficiarySearchModel query,
  ) async {
    final selectQuery = sql.select(sql.projectBeneficiary).join([]);
    final results = await (selectQuery
          ..where(
            buildAnd(
              [
                if (query.clientReferenceId != null)
                  sql.projectBeneficiary.clientReferenceId.equals(
                    query.clientReferenceId,
                  ),
                if (query.beneficiaryClientReferenceId != null)
                  sql.projectBeneficiary.beneficiaryClientReferenceId.equals(
                    query.beneficiaryClientReferenceId,
                  ),
                if (query.id != null)
                  sql.projectBeneficiary.id.equals(
                    query.id,
                  ),
                if (query.projectId != null)
                  sql.projectBeneficiary.projectId.equals(
                    query.projectId,
                  ),
                if (query.beneficiaryId != null)
                  sql.projectBeneficiary.beneficiaryId.equals(
                    query.beneficiaryId,
                  ),
                if (query.dateOfRegistrationTime != null)
                  sql.projectBeneficiary.dateOfRegistration.equals(
                    query.dateOfRegistration,
                  ),
              ],
            ),
          ))
        .get();

    return results.map((e) {
      final projectBeneficiary = e.readTable(sql.projectBeneficiary);

      return ProjectBeneficiaryModel(
        clientReferenceId: projectBeneficiary.clientReferenceId,
        tenantId: projectBeneficiary.tenantId,
        rowVersion: projectBeneficiary.rowVersion,
        id: projectBeneficiary.id,
        beneficiaryClientReferenceId:
            projectBeneficiary.beneficiaryClientReferenceId,
        beneficiaryId: projectBeneficiary.beneficiaryId,
        dateOfRegistration: projectBeneficiary.dateOfRegistration,
        projectId: projectBeneficiary.projectId,
      );
    }).toList();
  }

  @override
  FutureOr<void> create(ProjectBeneficiaryModel entity) async {
    final projectBeneficiaryCompanion = entity.companion;
    await sql.batch((batch) {
      batch.insert(sql.projectBeneficiary, projectBeneficiaryCompanion);
    });

    await super.create(entity);
  }

  @override
  FutureOr<void> update(ProjectBeneficiaryModel entity) async {
    final projectBeneficiaryCompanion = entity.companion;

    await sql.batch((batch) {
      batch.update(
        sql.projectBeneficiary,
        projectBeneficiaryCompanion,
        where: (table) => table.clientReferenceId.equals(
          entity.clientReferenceId,
        ),
      );
    });

    return super.update(entity);
  }

  @override
  DataModelType get type => DataModelType.projectBeneficiary;
}