class LoginModel {

  List? users;


  LoginModel({
    this.users
});

LoginModel patchState({
  List? users,
}) {
  return new LoginModel(
    users: users??this.users
  );
}
}