import 'component/deps_component.dart';
import 'list/dep_list_component.dart';
import 'controls/dep_controls_component.dart';

export 'dep_service.dart';
export 'component/deps_component.dart';
export 'controls/dep_controls_component.dart';
export 'dep/dep_component.dart';
export 'descriptor/descriptor_component.dart';
export 'list/dep_list_component.dart';

const List DEP_DIRECTIVES = const [ DepsComponent, DepList, DepControls];
