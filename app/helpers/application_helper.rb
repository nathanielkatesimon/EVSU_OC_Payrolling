module ApplicationHelper
  include Pagy::Frontend

  def enum_to_options(enum)
    enum.map { |obj| [obj.first.humanize, obj.first]}
  end
end
