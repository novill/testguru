module ApplicationHelper
  def github_url(author, repo)
    link_to 'Test guru', "https://github.com/#{author}/#{repo}", target: :black
  end

  def current_year
    Time.current.year
  end

  def flash_message(name)
    if flash.any?
      content_tag :p, flash[name], class: "flash #{name}"
    end
  end
end
