enum RegisterResponseStatus {
  Success,
  UserExists,
  PasswordShort,
  EmailInvalid,
  EmailAndPasswordRequired,
  NetworkError,
  UnknownError
}

class RegisterResponse {
  RegisterResponseStatus status;
  String errorMessage;
  String token;

  RegisterResponse(this.status, this.errorMessage, [this.token]);

  RegisterResponse.success(token, errorMessage)
      : this(RegisterResponseStatus.Success, errorMessage, token);

  RegisterResponse.userExists(errorMessage)
      : this(RegisterResponseStatus.UserExists, errorMessage);

  RegisterResponse.passwordShort(errorMessage)
      : this(RegisterResponseStatus.PasswordShort, errorMessage);

  RegisterResponse.emailInvalid(errorMessage)
      : this(RegisterResponseStatus.EmailInvalid, errorMessage);

  RegisterResponse.emailAndPasswordRequired(errorMessage)
      : this(RegisterResponseStatus.EmailAndPasswordRequired, errorMessage);

  RegisterResponse.networkError(errorMessage)
      : this(RegisterResponseStatus.NetworkError, errorMessage);

  RegisterResponse.unknownError(errorMessage)
      : this(RegisterResponseStatus.UnknownError, errorMessage);
}
