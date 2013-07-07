module ApplicationHelper
  def truncate(words, limit)
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
end
