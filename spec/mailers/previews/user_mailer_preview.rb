# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  private

  attr_reader :user

  public

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    @user = User.first
    user.create_activation_digest
    UserMailer.account_activation user
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset

end
