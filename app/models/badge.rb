class Badge < ApplicationRecord
  ALLOWED_OBJECT_TYPES = ['Category', 'Test', 'Level']
  belongs_to :badge_type
  belongs_to :object, polymorphic: true, optional: true

  scope :active, -> {where(active: true)}

  def to_s
    "#{badge_type.name} for #{object_type} #{object_id}"
  end

  def self.gain_new_badges(test_passage)
    gained_badges = []
    Badge.active.each do |badge|
      gained_badges += badge.gain(test_passage)
    end
    gained_badges
  end

  # TODO private

  def gain(test_passage)
    self.send("#{badge_type.b_type}_gain".to_sym, test_passage)
  end

  def no_fails_passage_gain(test_passage)
    return [] unless test_passage.passed

    user = test_passage.user
    test = test_passage.test
    if object_type == 'Test' && object_id == test.id
      has_fail = user.tests.find_by(id: test.id, test_passages: {passed: false})
      if has_fail
        []
      else
        [add_to_user(user)]
      end
    else
      []
    end
  end

  def whole_category_passed_gain(test_passage)
    return [] unless test_passage.passed

    user = test_passage.user
    test = test_passage.test
    category = test.category

    if object_type == 'Category' && object_id == category.id
      # это интересующий нас бейдж, проверяем все ли тесты пройдены по этой категории
      success_category_test_passed = user.tests.where(category: category, test_passages: {passed: true}).pluck(:id).uniq.sort
      all_category_test = category.tests.pluck(:id).sort

      success_category_test_passed == all_category_test ? [add_to_user(user)] : []
    else
      []
    end
  end

  def whole_level_passed_gain(test_passage)
    return [] unless test_passage.passed

    user = test_passage.user
    test = test_passage.test

    if object_type == 'Level' && object_id == test.level
      success_level_test_passed = user.tests.where(level: object_id, test_passages: {passed: true}).pluck(:id).uniq.sort
      all_level_test = Test.where(level: object_id).pluck(:id).sort

      success_level_test_passed == all_level_test ? [add_to_user(user)] : []
    else
      []
    end

  end

  def try_again_gain(test_passage)
    return [] if test_passage.passed
    user = test_passage.user
    test = test_passage.test

    fails = user.test_passages.where(test: test, passed: false).count
    fails >= 3 ? [add_to_user(user)] : []
  end

  def add_to_user(user)
    user_badge = user.user_badges.find_by(badge_id: id)
    if user_badge
      user_badge.count += 1
      user_badge.save!
    else
      user.user_badges.create!(badge_id: id, count: 1)
    end
    self
  end

end
