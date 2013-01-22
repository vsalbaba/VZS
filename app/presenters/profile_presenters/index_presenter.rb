# -*- encoding : utf-8 -*-
module ProfilePresenters
  class IndexPresenter
    def initialize
      @users = User.joins(:profile).order('second_name ASC, birthdate DESC').group_by(&:is_member_or_more?)
    end

    def members
      return [] if @users[true].blank?
      @members ||= @users[true].group_by { |user| user.profile.user_age_group }
    end

    def outsiders
      return [] if @users[false].blank?
      @outsiders ||= @users[false].group_by { |u| u.profile.user_age_group }
    end
  end
end
