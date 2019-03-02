module ApplicationHelper
  def github_url(author, repo)
    link_to 'Test guru', "https://github.com/#{author}/#{repo}", target: :black
  end

  def current_year
    Time.current.year
  end

  def humanize_attribute_names(fields_array)
    human_names = fields_array.map { |field| Test.human_attribute_name(field) }
    if block_given?
      human_names.each do |field_name|
        yield(field_name)
      end
    else
      human_names
    end
  end
end
