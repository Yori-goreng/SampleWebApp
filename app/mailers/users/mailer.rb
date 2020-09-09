class Users::Mailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'
  def confirmation_instructions(record, token, opts={})
    #opts属性を上書きすることで、Subjectやfromなどのヘッダー情報を変更
    if record.unconfirmed_email != nil
      opts[:subject] = "【LoalPlan】メールアドレス変更手続きを完了してください"
    else
      opts[:subject] = "【LoalPlan】会員登録完了"
    end
    super
  end
end