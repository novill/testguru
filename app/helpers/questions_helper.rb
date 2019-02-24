module QuestionsHelper
  def page_header
    "#{@question.new_record? ? 'Create' : 'Edit'} #{@question.test} question"
  end
end
