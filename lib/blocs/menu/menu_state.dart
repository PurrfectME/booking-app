part of 'menu_bloc.dart';

class MenuState extends Equatable {
  final bool isVisible;
  final MenuTab tab;

  const MenuState({
    this.isVisible = true,
    required this.tab
  });

  @override
  List<Object> get props => [isVisible, tab];
  
  MenuState copyWith({
    bool? isVisible,
    MenuTab? tab,
  }) => MenuState(
    isVisible: isVisible ?? this.isVisible,
    tab: tab ?? this.tab,
  );

}

// class MenuTabHome extends MenuTab {
//   const MenuTabHome({
//     bool isVisible = true,
//   }): super(isVisible: isVisible);
// }

// class MenuTabHistory extends MenuTab {
//   const MenuTabHistory({
//     bool isVisible = true,
//   }): super(isVisible: isVisible);
// }

// class MenuTabAccounts extends MenuTab {
//   const MenuTabAccounts({
//     bool isVisible = true,
//   }): super(isVisible: isVisible);
// }

// class MenuTabProfile extends MenuTab {
//   const MenuTabProfile({
//     bool isVisible = true,
//   }): super(isVisible: isVisible);
// }