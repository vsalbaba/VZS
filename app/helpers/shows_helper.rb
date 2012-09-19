# encoding: UTF-8
module ShowsHelper
  def food_for(show)
    food = []
    food << 'snídaně' if show.breakfast
    food << 'oběd' if show.lunch
    food << 'večeře' if show.dinner
    if food.empty?
      food << 'nezajištěno'
    end
    food.to_sentence
  end

  def reward(show)
    if show.payed_hours
      reward = []

      if show.paid
        reward << "cca #{number_to_currency(@show.pay)}"
      end
      reward << "#{@show.brigade_hours} brigádnických hodin"
      reward.join(' nebo ')
    else
      "neurčena"
    end
  end

  def subscribed_class(show, user)
    case current_user.subscribed_to?(show)
    when true then
      'slight_padding subscribed'
    when false then
      'slight_padding not_subscribed'
    else
      'slight_padding'
    end
  end

  def subscribed_notice(show, user)
    content_tag :p, :class => subscribed_class(show, user) do
      case user.subscribed_to? show
      when true then
        'Na tuto akci jste přihlášeni'
      when false then
        'Na tuto akci jste řekli že nepojedete'
      when nil then
        ''
      end
    end
  end

  def show_subscribed_count(show)
     show.people ? "#{show.subscribed_count}/#{show.people}" : show.subscribed_count.to_s
  end
end

