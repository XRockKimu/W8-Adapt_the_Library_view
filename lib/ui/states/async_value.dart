// lib/ui/states/async_value.dart

enum AsyncStatus { loading, data, error }

class AsyncValue<T> {
  final AsyncStatus status;
  final T? value;
  final String? errorMessage;

  AsyncValue.loading()
      : status = AsyncStatus.loading,
        value = null,
        errorMessage = null;

  AsyncValue.data(this.value)
      : status = AsyncStatus.data,
        errorMessage = null;

  AsyncValue.error(this.errorMessage)
      : status = AsyncStatus.error,
        value = null;

  bool get isLoading => status == AsyncStatus.loading;
  bool get hasData => status == AsyncStatus.data;
  bool get hasError => status == AsyncStatus.error;
}
