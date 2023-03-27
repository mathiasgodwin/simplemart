// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wishlist_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WishlistItem _$WishlistItemFromJson(Map<String, dynamic> json) {
  return _WishlistItem.fromJson(json);
}

/// @nodoc
mixin _$WishlistItem {
// required bool isWish,
  AllProductData get product => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WishlistItemCopyWith<WishlistItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishlistItemCopyWith<$Res> {
  factory $WishlistItemCopyWith(
          WishlistItem value, $Res Function(WishlistItem) then) =
      _$WishlistItemCopyWithImpl<$Res, WishlistItem>;
  @useResult
  $Res call({AllProductData product});
}

/// @nodoc
class _$WishlistItemCopyWithImpl<$Res, $Val extends WishlistItem>
    implements $WishlistItemCopyWith<$Res> {
  _$WishlistItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
  }) {
    return _then(_value.copyWith(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as AllProductData,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WishlistItemCopyWith<$Res>
    implements $WishlistItemCopyWith<$Res> {
  factory _$$_WishlistItemCopyWith(
          _$_WishlistItem value, $Res Function(_$_WishlistItem) then) =
      __$$_WishlistItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AllProductData product});
}

/// @nodoc
class __$$_WishlistItemCopyWithImpl<$Res>
    extends _$WishlistItemCopyWithImpl<$Res, _$_WishlistItem>
    implements _$$_WishlistItemCopyWith<$Res> {
  __$$_WishlistItemCopyWithImpl(
      _$_WishlistItem _value, $Res Function(_$_WishlistItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
  }) {
    return _then(_$_WishlistItem(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as AllProductData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WishlistItem implements _WishlistItem {
  const _$_WishlistItem({required this.product});

  factory _$_WishlistItem.fromJson(Map<String, dynamic> json) =>
      _$$_WishlistItemFromJson(json);

// required bool isWish,
  @override
  final AllProductData product;

  @override
  String toString() {
    return 'WishlistItem(product: $product)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WishlistItem &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, product);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WishlistItemCopyWith<_$_WishlistItem> get copyWith =>
      __$$_WishlistItemCopyWithImpl<_$_WishlistItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WishlistItemToJson(
      this,
    );
  }
}

abstract class _WishlistItem implements WishlistItem {
  const factory _WishlistItem({required final AllProductData product}) =
      _$_WishlistItem;

  factory _WishlistItem.fromJson(Map<String, dynamic> json) =
      _$_WishlistItem.fromJson;

  @override // required bool isWish,
  AllProductData get product;
  @override
  @JsonKey(ignore: true)
  _$$_WishlistItemCopyWith<_$_WishlistItem> get copyWith =>
      throw _privateConstructorUsedError;
}
