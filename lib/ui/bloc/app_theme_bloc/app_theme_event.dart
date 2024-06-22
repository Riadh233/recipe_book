sealed class AppThemeEvent {
  const AppThemeEvent();
}

final class AppThemeChanged extends AppThemeEvent {
  const AppThemeChanged(this.isDarkTheme);
  final bool isDarkTheme;
}

final class AppThemeStarted extends AppThemeEvent {
  const AppThemeStarted();
}