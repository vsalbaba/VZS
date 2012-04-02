class Ability
  include CanCan::Ability

  ADMIN = User::GROUP[:ADMIN]
  BOARD = User::GROUP[:BOARD]
  MEMBER = User::GROUP[:MEMBER]
  OUTSIDER = User::GROUP[:OUTSIDER]

  def initialize(user)
    user ||= User.new

    if user.group == ADMIN
      can :manage, :all
      return
    end

    if user.group == BOARD
      can :read, Article, :group => [OUTSIDER, MEMBER, BOARD]
      can :create, Article, :group => [nil, OUTSIDER, MEMBER, BOARD], :user_id => user.id
      can [:update, :save, :destroy], Article, :group => [OUTSIDER, MEMBER, BOARD], :user_id => user.id
    elsif user.group == MEMBER
      can :read, Article, :group => [OUTSIDER, MEMBER]
      can :create, Article, :group => [nil, OUTSIDER, MEMBER], :user_id => user.id
      can [:update, :save, :destroy], Article, :group => [OUTSIDER, MEMBER], :user_id => user.id
    elsif user.group == OUTSIDER
      can :read, Article, :group => OUTSIDER
    else
      can :read, Article, :group => OUTSIDER # neprihlaseni smi cist clanky pro necleny
    end

    # komentare
    can :read, Comment
    if [BOARD,MEMBER,OUTSIDER].include? user.group
      # vsichni registrovani smi psat komentare
      can :create, Comment, :article => { :commentable => true }
    end

    # pouze pro cleny
    if user.group and user.group >= MEMBER
      can :read_members, Profile
    end
  end
end
