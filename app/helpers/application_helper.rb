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

  # Хелпер, рисующий span тэг с иконкой из font-awesome
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def render_with_hashtags(text_of_question)
    text_of_question.gsub(/#[[:word:]]+/) do |word|
      link_to word, "/questions/hashtag/#{word.delete('#')}"
    end.html_safe
  end

  def render_as_hashtags(name)
    link_to "##{name}", "/questions/hashtag/#{name}"
  end
end
