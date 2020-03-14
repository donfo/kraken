/*
 * Copyright (C) 2019-present Alibaba Inc. All rights reserved.
 * Author: Kraken Team.
 */
const String STYLE = 'style';

/// The [CSSStyleDeclaration] interface represents an object that is a CSS
/// declaration block, and exposes style information and various style-related
/// methods and properties.
///
/// A [CSSStyleDeclaration] object can be exposed using three different APIs:
/// 1. Via [HTMLElement.style], which deals with the inline styles of a single
///    element (e.g., <div style="...">).
/// 2. Via the [CSSStyleSheet] API. For example,
///    document.styleSheets[0].cssRules[0].style returns a [CSSStyleDeclaration]
///    object on the first CSS rule in the document's first stylesheet.
/// 3. Via [Window.getComputedStyle()], which exposes the [CSSStyleDeclaration]
///    object as a read-only interface.
class CSSStyleDeclaration {
  CSSStyleDeclaration({ Map<String, dynamic> style }) {
    if (style != null ) {
      style.forEach((key, value) {
        if (value != null) this.setProperty(key, value: value.toString());
      });
    }
  }

  Map<String, String> _cssProperties = {};

  /// Textual representation of the declaration block.
  /// Setting this attribute changes the style.
  String get cssText {
    String _cssText = '';
    _cssProperties.forEach((key, value) {
      if (_cssText.isNotEmpty) _cssText += ' ';
      _cssText += '$key: $value;';
    });
    return _cssText;
  }

  // @TODO: Impl the cssText setter.

  /// The number of properties.
  int get length => _cssProperties.length;

  /// Returns the property value given a property name.
  /// value is a String containing the value of the property.
  /// If not set, returns the empty string.
  String getPropertyValue(String propertyName) {
    return _cssProperties[propertyName] ?? '';
  }

  /// Returns a property name.
  String item(int index) {
    return _cssProperties.keys.elementAt(index);
  }

  /// Removes a property from the CSS declaration block.
  String removeProperty(String property) {
    return _cssProperties.remove(property);
  }

  /// Modifies an existing CSS property or creates a new CSS property in
  /// the declaration block.
  void setProperty(String propertyName, { String value = '' }) {
    if (value != null) _cssProperties[propertyName] = value;
  }

  /// Override [] and []= operator to get/set style properties.
  operator [](String key) => this.getPropertyValue(key);
  operator []=(String key, value) {
    this.setProperty(key, value: value);
  }

  /// Check a css key is valid.
  bool contains(String key) {
    String value = getPropertyValue(key);
    return value != null && value.isNotEmpty;
  }

  String toString() => cssText;
}
