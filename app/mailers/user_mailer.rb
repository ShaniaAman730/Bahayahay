class UserMailer < ApplicationMailer
  default from: 'bahayahay.ph@gmail.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Our Platform!')
  end

  def realtor_approval_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your Realtor Account Has Been Approved')
  end

  def realtor_rejection_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your Realtor Account Has Been Rejected')
  end
end
