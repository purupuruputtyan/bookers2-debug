class ContactMailer < ApplicationMailer

  def contact_mail(contact, user)#メール送信のための”contact_mail”メソッドを作成
    @contact = contact#ビューファイルで@contactを使用するためらしい
    mail to: user.email, bcc: ENV["ACTION_MAILER_USER"], subject: "Notice an Event"
    #mail→メールを送信する
    #to: ◯◯◯→送信先を指定する
    #bcc: ◯◯◯→必要な場合のみ設定する。ccにもできる。ENV["ACTION_MAILER_USER"]は自分のメールアドレスらしい。
    #subject: ◯◯◯→任意のメールのタイトルを” ”内に記述する
    ##この「contact_mail」メソッドをコントローラーで呼び出すことで、メール送信が走る。
  end

end
