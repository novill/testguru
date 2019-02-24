module ApplicationHelper
  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}"
  end

  def current_year
    Time.now.year
  end
end
