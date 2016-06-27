class FavoriteMailer < ApplicationMailer
  default from: "r.alexramirez@outlook.com"

  def new_comment(user, post, comment)

    headers["Message-ID"] = "<comments/#{comment.id}@warm-sierra-79905.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@warm-sierra-79905.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@warm-sierra-79905.herokuapp.com>"

    @user = post
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end 
end
