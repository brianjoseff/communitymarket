module ApplicationHelper
  def nav_user_name
    current_user.name ? "#{current_user.name}" : "Your Page"
  end
  
  def truncate(words, limit)
    if words.nil?
      return
    end
    string_arr = words.split(' ')
    string_arr.count > limit ? "#{string_arr[0..(limit-1)].join(' ')}..." : words
  end
  
  def link_to_open_modal(text, url, modal_id, options = {})
    default_options = { remote: true, data: { target: modal_id, toggle: 'modal', type: 'html' }, class: 'modal-open' }
    link_to text, url, default_options
  end

  def link_to_edit_modal(url, modal_id)
    default_options = { remote: true, data: { target: modal_id, toggle: 'modal', type: 'html' }, class: 'btn modal-open' }
    link_to_edit url, default_options
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  
end
