import 'dart:html';

import 'package:bullseye/bullseye.dart';
import 'package:bullseye/elements/input.dart';
import 'package:bullseye/elements/text.dart' as text;
import 'package:bullseye/renderer/render_context.dart';
import 'package:bullseye/utils/utils.dart';

class Renderer {
  static late RenderContext renderContext;

  static Node render(Component element) {
    renderContext = RenderContext();
    return _renderComponent(element, false);
  }

  static void rerender(String internalId) {
    querySelector('.$internalId')?.replaceWith(
      _renderComponent(
        renderContext.internalIdNodes[internalId]!, 
        false // TODO: SET TO TRUE WHEN OPTIMIZING
      )
    );
  }

  static Node _renderComponent(Component element, bool isRerender) {
    if (element is StatelessComponent) return _buildStatelessComponent(element, isRerender);
    if (element is StatefulComponent) return _buildStatefulComponent(element, isRerender);

    switch (element.runtimeType) {
      case Div: return _buildDiv(element as Div, isRerender);
      case Span: return _buildSpan(element as Span, isRerender);
      case text.Text: return _buildText(element as text.Text, isRerender);
      case Button: return _buildButton(element as Button, isRerender);
      case Break: return _buildBreak(element as Break, isRerender);
      case Input: return _buildInput(element as Input, isRerender);
    }

    throw Exception('Component of type ${element.runtimeType} not implemented.');
  }

  static void _doHouseKeeping(Component component, Element element, bool isRerender) {
    if (isRerender) return;

    final internalId = component.internalId ?? Utils.generateInternalId();
    element.classes.add(internalId);
    component.internalId = internalId;
    if (component.id != null) element.id = component.id!;

    renderContext.internalIdNodes[internalId] = component;
  } 

  static Node _buildText(text.Text component, bool isRerender) {
    final newElement = SpanElement();
    _doHouseKeeping(component, newElement, isRerender);

    
    newElement.innerText = component.text;
    return newElement;
  }

  static Node _buildBreak(Break component, bool isRerender) {
    final newElement = BRElement();
    _doHouseKeeping(component, newElement, isRerender);
    return newElement;
  } 

  static Node _buildButton(Button component, bool isRerender) {
    final newElement = ButtonElement();
    _doHouseKeeping(component, newElement, isRerender);
    
    for (final child in component.children ?? []) {
      newElement.append(_renderComponent(child, isRerender));
    }
    newElement.onClick.listen((event) {
      component.onClick?.call();
    });
    return newElement;
  }

  static Node _buildDiv(Div component, bool isRerender) {
    final newElement = DivElement();
    _doHouseKeeping(component, newElement, isRerender);

    for (final child in component.children ?? []) {
      newElement.append(_renderComponent(child, isRerender));
    }
    return newElement;
  }

  static Node _buildSpan(Span component, bool isRerender) {
    final newElement = SpanElement();
    _doHouseKeeping(component, newElement, isRerender);

    for (final child in component.children ?? []) {
      newElement.append(_renderComponent(child, isRerender));
    }
    return newElement;
  }

  static Node _buildInput(Input component, bool isRerender) {
    final newElement = InputElement(type: component.type);
    _doHouseKeeping(component, newElement, isRerender);

    if (component.inputController != null) {
      newElement.value = component.inputController!.text ?? '';
      newElement.onChange.listen((event) {
        component.inputController!.text = newElement.value;
      });
    }

    return newElement;
  }

  static Node _buildStatelessComponent(StatelessComponent component, bool isRerender) {
    final newElement = _renderComponent(component.render(), isRerender);
    _doHouseKeeping(component, newElement as Element, isRerender);
    return newElement;
  }

  static Node _buildStatefulComponent(StatefulComponent component, bool isRerender) {
    final newElement = _renderComponent(component.render(), isRerender);
    _doHouseKeeping(component, newElement as Element, isRerender);
    return newElement;
  }
}