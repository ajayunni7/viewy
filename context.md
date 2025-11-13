# Notes App Machine Test – Project Context

## Current State
- Flutter counter starter remains in place as the active entry point in `lib/main.dart` with no feature integration yet.
- Feature scaffolding exists for authentication and notes (`lib/features/...`) but the Dart files are empty placeholders awaiting implementation.
- Core utilities for API access and token persistence (`lib/core/`) are present but not yet defined.

## Tooling & Dependencies
- Flutter SDK constraint: `^3.9.0`.
- Key packages declared in `pubspec.yaml`:
  - `flutter_riverpod ^3.0.3` for state management.
  - `dio ^5.9.0` for HTTP client support.
  - `shared_preferences ^2.5.3` for persisting the auth token.
- Default Flutter linting via `analysis_options.yaml`.

## Directory Snapshot (lib/)
- `main.dart`: current MaterialApp using default counter `MyHomePage` widget.
- `core/`
  - `api_service.dart`: intended HTTP client abstraction (empty).
  - `token_storage.dart`: intended local token management (empty).
- `features/auth/`
  - `controller/auth_controller.dart`: state layer placeholder.
  - `data/auth_service.dart`: API integration placeholder.
  - `presentation/login_screen.dart`: UI placeholder.
- `features/notes/`
  - `controller/notes_controller.dart`: state layer placeholder.
  - `data/notes_service.dart`: API integration placeholder.
  - `presentation/notes_list_screen.dart`, `notes_add_edit_screen.dart`: UI placeholders.
- `splash/splash_screen.dart`: reserved for splash implementation (empty).

## API Collection (Postman Reference)
- **POST** `/demoapi/v1/auth/login`
  - Form data: `email`, `password`.
  - Response includes `authToken` to be reused.
- **GET** `/demoapi/v1/todo/list`
  - Requires `Authorization: Bearer <token>` header.
- **POST** `/demoapi/v1/todo/add`
  - Form data: `title`, `description`.
  - Requires bearer token header.
- **POST** `/demoapi/v1/todo/edit`
  - Form data: `title`, `description`, `updateID`.
  - Requires bearer token header.
- **POST** `/demoapi/v1/todo/delete`
  - Form data: `deleteID`.
  - Requires bearer token header.

## Implementation Considerations
- Establish global token handling: obtain on login, persist securely, inject in every request, and handle invalid token responses by routing back to login.
- Choose BLoC or leverage existing Riverpod dependency for state flows (auth status, notes listing, mutation results, request lifecycle states).
- Centralize networking with Dio (base URL, interceptors for auth header, error mapping).
- Plan navigation: splash → login → notes list → add/edit.
- Ensure note list refreshes after add/edit/delete and deal with loading/error states across screens.

## Suggested Next Steps
1. Replace starter counter UI with splash/login routing structure.
2. Implement API service layer with token-aware Dio client and error handling.
3. Build auth state management, including persistent login via stored token.
4. Develop notes CRUD screens with Riverpod/BLoC state handling and optimistic refresh.
5. Add UX polish: loading indicators, validation, and invalid-token redirection.
