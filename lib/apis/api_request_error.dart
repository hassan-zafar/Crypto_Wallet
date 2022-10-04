import '../widget/custom_widgets/custom_toast.dart';

class APIRequestError {
  static void martketplace(int status) {
    if (status == 400) {
      CustomToast.errorToast(
        message: 'Bad Request: The server could not process the request',
      );
    } else if (status == 401) {
      CustomToast.errorToast(
        message:
            'Unauthorized: Your request lacks valid authentication credentials',
      );
    } else if (status == 402) {
      CustomToast.errorToast(
        message:
            'Payment Required: It being a paid subscription plan with an overdue balance',
      );
    } else if (status == 403) {
      CustomToast.errorToast(
        message: 'Forbidden: A permission issue',
      );
    } else if (status == 429) {
      CustomToast.errorToast(
        message: 'Too Many Requests: Request rate limit was exceeded',
      );
    } else if (status == 500) {
      CustomToast.errorToast(
        message:
            'Internal Server Error: An unexpected server issue was encountered',
      );
    } else {
      CustomToast.errorToast(
        message: 'Error occure due to unknow reason',
      );
    }
  }
}
