# Routing

### The Routing module takes care of navigation and routing within the app. It provides a seamless and easier developing experience by directing users to the appropriate screens and content based on their actions and inputs.

This file contains a collection of utility functions provides a global key for the app's navigator. This can be used to access the navigator from anywhere in the app.
### for easy navigation please click on one of functions below to navigate to it's explanation

- [dismissKeyboard](#dismisskeyboard)
- [popSheet](#popsheet)
- [closeDialog](#closedialog)
- [displayBottomSheet](#displaybottomsheetcontext-widget-bottomsheet)
- [navigateToRoute](#navigatetoroutebuildcontext-context-dynamic-routeclass)
- [navigateAndReplaceRoute](#navigateandreplaceroutebuildcontext-context-dynamic-routeclass)
- [navigateAndRemoveUntilRoute](#navigateandremoveuntilroutebuildcontext-context-dynamic-routeclass)
- [goBackHome](#gobackbuildcontext-context)
- [goBack](#gobackbuildcontext-context)
- [moveAppToBackGround](#moveapptobackground)
- [openVModelMenu](#openvmodelmenubuildcontext-context-bool-isnottabscreen--false)





## `dismissKeyboard()`

This function dismisses the keyboard that is currently focused.

- ### Parameters

  - None.


## `popSheet()`

This function dismisses the current bottom sheet.

- ### Parameters

  - None.


## `closeDialog()`

This function dismisses the current dialog.

- ### Parameters

  - None.


## `displayBottomSheet(context, Widget bottomSheet)`

This function displays a bottom sheet with the given widget. The bottom sheet will be positioned below the current content.

- ### Parameters

  - `context`: The build context of the widget that is calling this function.
  - `bottomSheet`: The widget that will be displayed in the bottom sheet.

## `navigateToRoute(BuildContext context, dynamic routeClass)`

This function navigates to the given route. The route can be a string or a widget.

- ### Parameters

  - `context`: The build context of the widget that is calling this function.
  - `routeClass`: The class of the widget that will be displayed on the new route.


## `navigateAndReplaceRoute(BuildContext? context, dynamic routeClass)`

This function navigates to the given route and replaces the current route.

- ### Parameters

  - `context`: The build context of the widget that is calling this function.
  - `routeClass`: The class of the widget that will be displayed on the new route.


## `navigateAndRemoveUntilRoute(BuildContext? context, dynamic routeClass)`
This function navigates to the given route and removes all previous routes from the stack.

- ### Parameters

  - `context`: The build context of the widget that is calling this function.
  - `routeClass`: The class of the widget that will be displayed on the new route.


## `goBackHome(BuildContext context)`

This function navigates back to the home screen.

- ### Parameters

  - `context`: The build context of the widget that is calling this function.


## `goBack(BuildContext context)`

This function navigates back one step.

- ### Parameters

  - `context`: The build context of the widget that is calling this function.


## `moveAppToBackGround()`

This function moves the app to the background.

- ### Parameters

  - None.

## `openVModelMenu(BuildContext context, {bool isNotTabScreen = false})`

This function opens the vmodel menu. The menu will be displayed as a bottom sheet.

- ### Parameters

  - `context`: The build context of the widget that is calling this function.
  - `isNotTabScreen`: A boolean value that indicates whether the menu is being opened from a tab screen. If this value is true, the menu will be displayed at the bottom of the screen. If this value is false, the menu will be displayed at the top of the screen.
