# Grocery-Store
E-Commerce 

Flutter application that:
- Fetches shops from API
- Supports search (debounced)
- Sort by ETA / Minimum Order
- Filter by Open Only
- Uses Bloc for state management
- MVVM

## Environment Configuration

This project requires a secret key to access the API.

Run the app using:

flutter run --dart-define=SECRET_KEY=your_secret_key_here

For security reasons, the secret key is not committed to the repository.
