// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'boundary.dart';

class BoundarySearchModelMapper
    extends SubClassMapperBase<BoundarySearchModel> {
  BoundarySearchModelMapper._();

  static BoundarySearchModelMapper? _instance;
  static BoundarySearchModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoundarySearchModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BoundarySearchModel';

  static String? _$boundaryType(BoundarySearchModel v) => v.boundaryType;
  static const Field<BoundarySearchModel, String> _f$boundaryType =
      Field('boundaryType', _$boundaryType, opt: true);
  static String? _$tenantId(BoundarySearchModel v) => v.tenantId;
  static const Field<BoundarySearchModel, String> _f$tenantId =
      Field('tenantId', _$tenantId, opt: true);
  static String? _$code(BoundarySearchModel v) => v.code;
  static const Field<BoundarySearchModel, String> _f$code =
      Field('code', _$code, opt: true);
  static int? _$boundaryNum(BoundarySearchModel v) => v.boundaryNum;
  static const Field<BoundarySearchModel, int> _f$boundaryNum =
      Field('boundaryNum', _$boundaryNum, opt: true);
  static bool? _$isSingle(BoundarySearchModel v) => v.isSingle;
  static const Field<BoundarySearchModel, bool> _f$isSingle =
      Field('isSingle', _$isSingle, opt: true);
  static String? _$boundaryCode(BoundarySearchModel v) => v.boundaryCode;
  static const Field<BoundarySearchModel, String> _f$boundaryCode =
      Field('boundaryCode', _$boundaryCode, opt: true);
  static AdditionalFields? _$additionalFields(BoundarySearchModel v) =>
      v.additionalFields;
  static const Field<BoundarySearchModel, AdditionalFields>
      _f$additionalFields =
      Field('additionalFields', _$additionalFields, opt: true);
  static AuditDetails? _$auditDetails(BoundarySearchModel v) => v.auditDetails;
  static const Field<BoundarySearchModel, AuditDetails> _f$auditDetails =
      Field('auditDetails', _$auditDetails, opt: true);

  @override
  final MappableFields<BoundarySearchModel> fields = const {
    #boundaryType: _f$boundaryType,
    #tenantId: _f$tenantId,
    #code: _f$code,
    #boundaryNum: _f$boundaryNum,
    #isSingle: _f$isSingle,
    #boundaryCode: _f$boundaryCode,
    #additionalFields: _f$additionalFields,
    #auditDetails: _f$auditDetails,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = MappableClass.useAsDefault;
  @override
  late final ClassMapperBase superMapper =
      EntitySearchModelMapper.ensureInitialized();

  static BoundarySearchModel _instantiate(DecodingData data) {
    return BoundarySearchModel.ignoreDeleted(
        boundaryType: data.dec(_f$boundaryType),
        tenantId: data.dec(_f$tenantId),
        code: data.dec(_f$code),
        boundaryNum: data.dec(_f$boundaryNum),
        isSingle: data.dec(_f$isSingle),
        boundaryCode: data.dec(_f$boundaryCode),
        additionalFields: data.dec(_f$additionalFields),
        auditDetails: data.dec(_f$auditDetails));
  }

  @override
  final Function instantiate = _instantiate;

  static BoundarySearchModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoundarySearchModel>(map);
  }

  static BoundarySearchModel fromJson(String json) {
    return ensureInitialized().decodeJson<BoundarySearchModel>(json);
  }
}

mixin BoundarySearchModelMappable {
  String toJson() {
    return BoundarySearchModelMapper.ensureInitialized()
        .encodeJson<BoundarySearchModel>(this as BoundarySearchModel);
  }

  Map<String, dynamic> toMap() {
    return BoundarySearchModelMapper.ensureInitialized()
        .encodeMap<BoundarySearchModel>(this as BoundarySearchModel);
  }

  BoundarySearchModelCopyWith<BoundarySearchModel, BoundarySearchModel,
          BoundarySearchModel>
      get copyWith => _BoundarySearchModelCopyWithImpl(
          this as BoundarySearchModel, $identity, $identity);
  @override
  String toString() {
    return BoundarySearchModelMapper.ensureInitialized()
        .stringifyValue(this as BoundarySearchModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BoundarySearchModelMapper.ensureInitialized()
                .isValueEqual(this as BoundarySearchModel, other));
  }

  @override
  int get hashCode {
    return BoundarySearchModelMapper.ensureInitialized()
        .hashValue(this as BoundarySearchModel);
  }
}

extension BoundarySearchModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoundarySearchModel, $Out> {
  BoundarySearchModelCopyWith<$R, BoundarySearchModel, $Out>
      get $asBoundarySearchModel =>
          $base.as((v, t, t2) => _BoundarySearchModelCopyWithImpl(v, t, t2));
}

abstract class BoundarySearchModelCopyWith<$R, $In extends BoundarySearchModel,
    $Out> implements EntitySearchModelCopyWith<$R, $In, $Out> {
  @override
  AdditionalFieldsCopyWith<$R, AdditionalFields, AdditionalFields>?
      get additionalFields;
  @override
  AuditDetailsCopyWith<$R, AuditDetails, AuditDetails>? get auditDetails;
  @override
  $R call(
      {String? boundaryType,
      String? tenantId,
      String? code,
      int? boundaryNum,
      bool? isSingle,
      String? boundaryCode,
      AdditionalFields? additionalFields,
      AuditDetails? auditDetails});
  BoundarySearchModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BoundarySearchModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoundarySearchModel, $Out>
    implements BoundarySearchModelCopyWith<$R, BoundarySearchModel, $Out> {
  _BoundarySearchModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoundarySearchModel> $mapper =
      BoundarySearchModelMapper.ensureInitialized();
  @override
  AdditionalFieldsCopyWith<$R, AdditionalFields, AdditionalFields>?
      get additionalFields => $value.additionalFields?.copyWith
          .$chain((v) => call(additionalFields: v));
  @override
  AuditDetailsCopyWith<$R, AuditDetails, AuditDetails>? get auditDetails =>
      $value.auditDetails?.copyWith.$chain((v) => call(auditDetails: v));
  @override
  $R call(
          {Object? boundaryType = $none,
          Object? tenantId = $none,
          Object? code = $none,
          Object? boundaryNum = $none,
          Object? isSingle = $none,
          Object? boundaryCode = $none,
          Object? additionalFields = $none,
          Object? auditDetails = $none}) =>
      $apply(FieldCopyWithData({
        if (boundaryType != $none) #boundaryType: boundaryType,
        if (tenantId != $none) #tenantId: tenantId,
        if (code != $none) #code: code,
        if (boundaryNum != $none) #boundaryNum: boundaryNum,
        if (isSingle != $none) #isSingle: isSingle,
        if (boundaryCode != $none) #boundaryCode: boundaryCode,
        if (additionalFields != $none) #additionalFields: additionalFields,
        if (auditDetails != $none) #auditDetails: auditDetails
      }));
  @override
  BoundarySearchModel $make(
          CopyWithData data) =>
      BoundarySearchModel.ignoreDeleted(
          boundaryType: data.get(#boundaryType, or: $value.boundaryType),
          tenantId: data.get(#tenantId, or: $value.tenantId),
          code: data.get(#code, or: $value.code),
          boundaryNum: data.get(#boundaryNum, or: $value.boundaryNum),
          isSingle: data.get(#isSingle, or: $value.isSingle),
          boundaryCode: data.get(#boundaryCode, or: $value.boundaryCode),
          additionalFields:
              data.get(#additionalFields, or: $value.additionalFields),
          auditDetails: data.get(#auditDetails, or: $value.auditDetails));

  @override
  BoundarySearchModelCopyWith<$R2, BoundarySearchModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _BoundarySearchModelCopyWithImpl($value, $cast, t);
}

class BoundaryModelMapper extends ClassMapperBase<BoundaryModel> {
  BoundaryModelMapper._();

  static BoundaryModelMapper? _instance;
  static BoundaryModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoundaryModelMapper._());
      EntityModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoundaryModel';

  static String? _$code(BoundaryModel v) => v.code;
  static const Field<BoundaryModel, String> _f$code =
      Field('code', _$code, opt: true);
  static String? _$name(BoundaryModel v) => v.name;
  static const Field<BoundaryModel, String> _f$name =
      Field('name', _$name, opt: true);
  static String? _$label(BoundaryModel v) => v.label;
  static const Field<BoundaryModel, String> _f$label =
      Field('label', _$label, opt: true);
  static String? _$latitude(BoundaryModel v) => v.latitude;
  static const Field<BoundaryModel, String> _f$latitude =
      Field('latitude', _$latitude, opt: true);
  static String? _$longitude(BoundaryModel v) => v.longitude;
  static const Field<BoundaryModel, String> _f$longitude =
      Field('longitude', _$longitude, opt: true);
  static String? _$area(BoundaryModel v) => v.area;
  static const Field<BoundaryModel, String> _f$area =
      Field('area', _$area, opt: true);
  static String? _$materializedPath(BoundaryModel v) => v.materializedPath;
  static const Field<BoundaryModel, String> _f$materializedPath =
      Field('materializedPath', _$materializedPath, opt: true);
  static String? _$tenantId(BoundaryModel v) => v.tenantId;
  static const Field<BoundaryModel, String> _f$tenantId =
      Field('tenantId', _$tenantId, opt: true);
  static int? _$boundaryNum(BoundaryModel v) => v.boundaryNum;
  static const Field<BoundaryModel, int> _f$boundaryNum =
      Field('boundaryNum', _$boundaryNum, opt: true);
  static int? _$rowVersion(BoundaryModel v) => v.rowVersion;
  static const Field<BoundaryModel, int> _f$rowVersion =
      Field('rowVersion', _$rowVersion, opt: true);
  static List<BoundaryModel> _$children(BoundaryModel v) => v.children;
  static const Field<BoundaryModel, List<BoundaryModel>> _f$children =
      Field('children', _$children, opt: true, def: const []);
  static AuditDetails? _$auditDetails(BoundaryModel v) => v.auditDetails;
  static const Field<BoundaryModel, AuditDetails> _f$auditDetails =
      Field('auditDetails', _$auditDetails, opt: true);
  static bool? _$isDeleted(BoundaryModel v) => v.isDeleted;
  static const Field<BoundaryModel, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static ClientAuditDetails? _$clientAuditDetails(BoundaryModel v) =>
      v.clientAuditDetails;
  static const Field<BoundaryModel, ClientAuditDetails> _f$clientAuditDetails =
      Field('clientAuditDetails', _$clientAuditDetails, mode: FieldMode.member);

  @override
  final MappableFields<BoundaryModel> fields = const {
    #code: _f$code,
    #name: _f$name,
    #label: _f$label,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #area: _f$area,
    #materializedPath: _f$materializedPath,
    #tenantId: _f$tenantId,
    #boundaryNum: _f$boundaryNum,
    #rowVersion: _f$rowVersion,
    #children: _f$children,
    #auditDetails: _f$auditDetails,
    #isDeleted: _f$isDeleted,
    #clientAuditDetails: _f$clientAuditDetails,
  };
  @override
  final bool ignoreNull = true;

  static BoundaryModel _instantiate(DecodingData data) {
    return BoundaryModel(
        code: data.dec(_f$code),
        name: data.dec(_f$name),
        label: data.dec(_f$label),
        latitude: data.dec(_f$latitude),
        longitude: data.dec(_f$longitude),
        area: data.dec(_f$area),
        materializedPath: data.dec(_f$materializedPath),
        tenantId: data.dec(_f$tenantId),
        boundaryNum: data.dec(_f$boundaryNum),
        rowVersion: data.dec(_f$rowVersion),
        children: data.dec(_f$children),
        auditDetails: data.dec(_f$auditDetails),
        isDeleted: data.dec(_f$isDeleted));
  }

  @override
  final Function instantiate = _instantiate;

  static BoundaryModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoundaryModel>(map);
  }

  static BoundaryModel fromJson(String json) {
    return ensureInitialized().decodeJson<BoundaryModel>(json);
  }
}

mixin BoundaryModelMappable {
  String toJson() {
    return BoundaryModelMapper.ensureInitialized()
        .encodeJson<BoundaryModel>(this as BoundaryModel);
  }

  Map<String, dynamic> toMap() {
    return BoundaryModelMapper.ensureInitialized()
        .encodeMap<BoundaryModel>(this as BoundaryModel);
  }

  BoundaryModelCopyWith<BoundaryModel, BoundaryModel, BoundaryModel>
      get copyWith => _BoundaryModelCopyWithImpl(
          this as BoundaryModel, $identity, $identity);
  @override
  String toString() {
    return BoundaryModelMapper.ensureInitialized()
        .stringifyValue(this as BoundaryModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BoundaryModelMapper.ensureInitialized()
                .isValueEqual(this as BoundaryModel, other));
  }

  @override
  int get hashCode {
    return BoundaryModelMapper.ensureInitialized()
        .hashValue(this as BoundaryModel);
  }
}

extension BoundaryModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoundaryModel, $Out> {
  BoundaryModelCopyWith<$R, BoundaryModel, $Out> get $asBoundaryModel =>
      $base.as((v, t, t2) => _BoundaryModelCopyWithImpl(v, t, t2));
}

abstract class BoundaryModelCopyWith<$R, $In extends BoundaryModel, $Out>
    implements EntityModelCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, BoundaryModel,
      BoundaryModelCopyWith<$R, BoundaryModel, BoundaryModel>> get children;
  @override
  AuditDetailsCopyWith<$R, AuditDetails, AuditDetails>? get auditDetails;
  @override
  $R call(
      {String? code,
      String? name,
      String? label,
      String? latitude,
      String? longitude,
      String? area,
      String? materializedPath,
      String? tenantId,
      int? boundaryNum,
      int? rowVersion,
      List<BoundaryModel>? children,
      AuditDetails? auditDetails,
      bool? isDeleted});
  BoundaryModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BoundaryModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoundaryModel, $Out>
    implements BoundaryModelCopyWith<$R, BoundaryModel, $Out> {
  _BoundaryModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoundaryModel> $mapper =
      BoundaryModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, BoundaryModel,
          BoundaryModelCopyWith<$R, BoundaryModel, BoundaryModel>>
      get children => ListCopyWith($value.children,
          (v, t) => v.copyWith.$chain(t), (v) => call(children: v));
  @override
  AuditDetailsCopyWith<$R, AuditDetails, AuditDetails>? get auditDetails =>
      $value.auditDetails?.copyWith.$chain((v) => call(auditDetails: v));
  @override
  $R call(
          {Object? code = $none,
          Object? name = $none,
          Object? label = $none,
          Object? latitude = $none,
          Object? longitude = $none,
          Object? area = $none,
          Object? materializedPath = $none,
          Object? tenantId = $none,
          Object? boundaryNum = $none,
          Object? rowVersion = $none,
          List<BoundaryModel>? children,
          Object? auditDetails = $none,
          Object? isDeleted = $none}) =>
      $apply(FieldCopyWithData({
        if (code != $none) #code: code,
        if (name != $none) #name: name,
        if (label != $none) #label: label,
        if (latitude != $none) #latitude: latitude,
        if (longitude != $none) #longitude: longitude,
        if (area != $none) #area: area,
        if (materializedPath != $none) #materializedPath: materializedPath,
        if (tenantId != $none) #tenantId: tenantId,
        if (boundaryNum != $none) #boundaryNum: boundaryNum,
        if (rowVersion != $none) #rowVersion: rowVersion,
        if (children != null) #children: children,
        if (auditDetails != $none) #auditDetails: auditDetails,
        if (isDeleted != $none) #isDeleted: isDeleted
      }));
  @override
  BoundaryModel $make(CopyWithData data) => BoundaryModel(
      code: data.get(#code, or: $value.code),
      name: data.get(#name, or: $value.name),
      label: data.get(#label, or: $value.label),
      latitude: data.get(#latitude, or: $value.latitude),
      longitude: data.get(#longitude, or: $value.longitude),
      area: data.get(#area, or: $value.area),
      materializedPath:
          data.get(#materializedPath, or: $value.materializedPath),
      tenantId: data.get(#tenantId, or: $value.tenantId),
      boundaryNum: data.get(#boundaryNum, or: $value.boundaryNum),
      rowVersion: data.get(#rowVersion, or: $value.rowVersion),
      children: data.get(#children, or: $value.children),
      auditDetails: data.get(#auditDetails, or: $value.auditDetails),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted));

  @override
  BoundaryModelCopyWith<$R2, BoundaryModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BoundaryModelCopyWithImpl($value, $cast, t);
}
