# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  ADMIN = User::GROUP[:ADMIN]
  BOARD = User::GROUP[:BOARD]
  MEMBER = User::GROUP[:MEMBER]
  OUTSIDER = User::GROUP[:OUTSIDER]
  ALL = [OUTSIDER, MEMBER, BOARD]

  def initialize(user)
    user ||= User.new

    if user.group == ADMIN or user.group == BOARD
      can :manage, :all
      can :approve, Article
      return
    end

    article_rules(user)
    attachments_rules(user)
    comments_rules(user)
    events_rules(user)
    gallery_rules(user)
    life_guarding_timespans_rules(user)
    page_rules(user)
    photo_rules(user)
    user_manager_rules(user)
    user_rules(user)
  end

  def life_guarding_timespans_rules(user)
    if user.group? MEMBER
      can :read, LifeGuardingTimespan
    end
  end

  def article_rules(user)
    if user.group? MEMBER
      can :read, Article, :group => [OUTSIDER, MEMBER]
      can :create, Article, :group => [nil, OUTSIDER, MEMBER], :user_id => user.id
      can [:update, :save, :destroy], Article, :group => [OUTSIDER, MEMBER], :user_id => user.id
    elsif user.group? OUTSIDER
      can :read, Article, :group => OUTSIDER
    else
      can :read, Article, :group => OUTSIDER # neprihlaseni smi cist clanky pro necleny
    end
  end

  def events_rules(user)
    if user.group? MEMBER
      can :read, Event, :group => [nil, OUTSIDER, MEMBER]
      can :create, Event, :group => [nil, OUTSIDER, MEMBER]
      can [:update, :save, :destroy], Event, :group => [nil, OUTSIDER, MEMBER]
    elsif user.group? OUTSIDER
      can :read, Event, :group => [nil, OUTSIDER]
    else
      can :read, Event, :group => [nil, OUTSIDER] # neprihlaseni smi cist clanky pro necleny
    end
  end

  def comments_rules(user)
    # komentare
    can :read, Comment
    if [BOARD,MEMBER,OUTSIDER].include? user.group
      # vsichni registrovani smi psat komentare
      can :create, Comment, :article => { :commentable => true }
    end
  end

  def attachments_rules(user)
    can :create, Attachment do |att|
      att.user_id == user.id and
      att.article.group <= user.group
    end
    can [:update, :save, :destroy], Attachment, :user_id => user.id
    if user.group >= BOARD
      can :manage, Attachment
    end
  end

  def photo_rules(user)
    if user.admin? or user.board? then
      can :manage, Photo
    else
      can :read, Photo
      can :manage, Photo do |p|
        p.gallery.user == user
      end
    end
  end

  def gallery_rules(user)
    if user.group? MEMBER
      can :read, Gallery, :group => [OUTSIDER, MEMBER]
      can :create, Gallery, :group => [nil, OUTSIDER, MEMBER], :user_id => user.id
      can [:update, :save, :destroy], Gallery, :group => [OUTSIDER, MEMBER], :user_id => user.id
    elsif user.group? OUTSIDER
      can :read, Gallery, :group => OUTSIDER
    else
      can :read, Gallery, :group => OUTSIDER # neprihlaseni smi prohlizet galerie pro necleny
    end

    # :read, Photo nepotrebujeme - odkazy na fotky jdou primo
    unless user.group? OUTSIDER
      can [:create, :update, :save, :destroy], Photo do |p|
        user.group >= p.gallery.group
      end
    end
  end

  def user_rules(user)
    can :create, User do |u|
      u.group? OUTSIDER
    end

    # smi zobrazovat pouze sebe (show/index)
    can :read, User, :id => user.id

    if user.group >= MEMBER
      # clenove smi ...
      # ... prohlizet seznam clenu
      can :read_members, User
      can :read, User

      # ... upravovat rozsirujici atributy sveho profil
      can :update_extended, Profile, :user_id => user.id

      # menit svuj uzivatelsky profil
      can [:update, :save], User do |u|
        u.id == user.id and
        u.group? user.group
      end
    else
      can [:update, :save], User do |u|
        u.id == user.id and
        u.group? user.group and
        u.profile.birthnumber == user.profile.birthnumber and
        u.profile.birthdate == user.profile.birthdate and
        u.profile.address == user.profile.address
      end
    end
  end

  def page_rules(user)
    can :read, Page
    if user.group? BOARD
      can :manage, Page
    end
  end

  def user_manager_rules(user)
    if user.group >= BOARD
      # clenove vyboru a vyssi smi spravovat uzivatele a rozsirujici atributy
      # profilu (RC, Adresa, Skupina apod)
      can :manage, User
      can :update_extended, Profile
    end
  end
end
