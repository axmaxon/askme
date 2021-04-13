module ApplicationHelper
  # Этот метод возвращает ссылку на аватарку пользователя, если она у него есть.
  # Или ссылку на дефолтную аватарку, которую положим в app/frontend/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_pack_path('media/images/avatar.jpg')
    end
  end
end
