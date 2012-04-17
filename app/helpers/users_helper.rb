module UsersHelper
  GROUP_NAMES = {
    User::GROUP[:OUTSIDER] => 'Nečlen',
    User::GROUP[:MEMBER] => 'Člen',
    User::GROUP[:BOARD] => 'Výbor',
    User::GROUP[:ADMIN] => 'Administrátor'
  }

  def group_names
    return GROUP_NAMES.map { |id, name| [name, id] }
  end

  def group_name(group_id)
    GROUP_NAMES[ group_id ]
  end

  def full_name(user)
    fn = user.profile.full_name
    return user.login if fn == ' '
    return fn
  end
end

