class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.group.ident == 'admin'
      can :manage, :all
    else
      case user.group.ident
      when 'board'
        can [:read], Article, :group_id => [1,2,3]
        can [:create,:update,:save,:destroy], Article, :group_id => [1,2,3], :user_id => user.id
        # FIXME: nemohou nahodou osoby z vyboru menit cizi clanky apod?
      when 'member'
        can [:read], Article, :group_id => [1,2]
        can [:create,:update,:save,:destroy], Article, :group_id => [1,2], :user_id => user.id
      when 'outsider'
        can :read, Article, :group_id => 1
      else
        can :read, Article, :group_id => 1 # nyni smi i neregistrovany cist clanky pro 'necleny'
      end
    end
  end
end
