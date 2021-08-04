# frozen_string_literal: true

module Marvel
  class ComicLiked
    attr_reader :comic, :user

    def initialize(comic, user)
      @comic = comic
      @user = user
    end

    def liked
      @liked ||= user.try(:user_marvel_comics).try(:where, { comic_id: comic.id }).try(:liked) || false
    end

    def type
      :marvel
    end
  end
end
