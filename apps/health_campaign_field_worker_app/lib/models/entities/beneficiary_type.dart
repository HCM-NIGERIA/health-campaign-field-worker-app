// Generated using mason. Do not modify by hand
import 'package:dart_mappable/dart_mappable.dart';

part 'beneficiary_type.mapper.dart';

@MappableEnum(caseStyle: CaseStyle.upperCase)
enum BeneficiaryType {
  @MappableValue("INDIVIDUAL")
  individual,
  @MappableValue("SCHOOL")
  school,
  @MappableValue("HOUSEHOLD")
  household,
  @MappableValue("PRODUCT")
  product,
  @MappableValue("5-14YEARS")
  individual1,
  @MappableValue("14+YEARS")
  individual2,
  @MappableValue("15+YEARS")
  individual3,
  @MappableValue("IVERMECTIN")
  ivermectin,
  @MappableValue("ALBENDAZOLE")
  albendazole,
  @MappableValue("SETTLEMENT-INDIVIDUAL")
  settlementIndividual,
  @MappableValue("SCHOOL-INDIVIDUAL")
  schoolIndividual,
  @MappableValue("SETTLEMENT-PRODUCT")
  settlementProduct,
  @MappableValue("SCHOOL-PRODUCT")
  schoolProduct,
  ;
}
