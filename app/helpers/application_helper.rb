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

  # Рисует span тэг с иконкой из font-awesome
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  # Рендерит текст вопроса или ответа с хештегами в виде ссылок.
  def render_with_hashtags(some_text)
    some_text.gsub(/#[[:word:]]+/) do |word|

      hashtag = get_hashtag_by_name(word)

      if hashtag.blank?
        link_to word, "#{Rails.root}/public/404.html"
      else
        link_to word, hashtag_path(hashtag)
      end
    end.html_safe
  end

  # Рендерит имя хэштега в виде ссылки с якорем #
  def render_as_hashtags(hashtag)
    link_to "##{hashtag.name}", hashtag_path(hashtag)
  end
end
