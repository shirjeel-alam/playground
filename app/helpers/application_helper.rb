module ApplicationHelper
  def bootstrap_class_for(flash_type)
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(
        content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do 
          concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
          concat message 
        end
        )
    end
    nil
  end

  def bootstrap_devise_error_messages!
    resource ||= @user
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert alert-danger alert-block">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      <h5>#{sentence}</h5>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
