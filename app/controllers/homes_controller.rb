class HomesController < ApplicationController
  def top
    @posts = Post.left_joins(:favorites).group(:id).order('count(post_id) desc').limit(5)

  end
end
