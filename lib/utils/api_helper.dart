bool isNoInternetIssue(String error) {
  return error
      .startsWith('ClientException with SocketException: Failed host lookup:');
}

bool isNoInternetIssueUpdateProfile(String error) {
  return error
      .startsWith('ClientException with SocketException: Failed host lookup:');
}

const String noNetWorkMessage = 'No internet connection! please try again.';
