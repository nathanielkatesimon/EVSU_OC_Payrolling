module ApplicationHelper
  include Pagy::Frontend

  def enum_to_options(enum)
    enum.map { |obj| [obj.first.humanize, obj.first]}
  end

  def render_editable_entry_or_value(entry, attribute, current_user)
    if current_user.human_resources? && entry.payroll.pending?
      entry_type = entry.payroll.entry_type.to_s.gsub("_", "-")
  
      tag.input(class: 'form-control form-control-sm',
                data: { action: "input->#{entry_type}#calculate", id: entry.id, value: attribute },
                type: 'number', style: 'width:11ch;', 
                authenticity_token: form_authenticity_token, 
                value: entry.send(attribute))
    else
      entry.send(attribute)
    end
  end

  def render_checkbox_if_needed(entry, current_user)
    if (current_user.human_resources? || current_user.accounting?) && entry.payroll.pending?
      tag.span(class: 'form-check') do
        tag.input(class: 'form-check-input',
                  type: 'checkbox',
                  id: 'flexCheckDefault',
                  data: { controller: 'entry-inclusion',
                          entry_type: entry.payroll.user_type.to_s,
                          entry_id: entry.id,
                          authenticity_token: form_authenticity_token,
                          action: 'input->entry-inclusion#updateEntryInclusion' },
                  checked: entry.included)
      end
    end
  end

end
