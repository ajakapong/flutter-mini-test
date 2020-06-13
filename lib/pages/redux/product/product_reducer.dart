import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_app/models/product_modal.dart';
import 'package:my_app/pages/redux/product/product_action.dart';

@immutable
class ProductState {
  final bool isLoading;
  final List<Course> course;
  ProductState({this.isLoading = true, this.course = const []});

  ProductState copyWith({List<Course> course, bool isLoading}) {
    return ProductState(
        course: course ?? this.course, isLoading: isLoading ?? this.isLoading);
  }
}

productReducer(ProductState prevState, dynamic action) {
  if (action is ProductAction) {
    return prevState.copyWith(
        course: action.productState.course,
        isLoading: action.productState.isLoading);
  }
  return prevState;
}
