module LoginSupport
  def login_as(user)
    post login_path,
      params: { session: {
        user_name: user.user_name,
        password: user.password
      }}
  end
end