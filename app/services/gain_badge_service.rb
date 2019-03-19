class GainBadgeService

  def initialize(test_passage)
    @test_passage = test_passage
    @passed = test_passage.passed
    @user = test_passage.user
    @test = test_passage.test
    @category = @test.category
    @level = @test.level
  end

  def call
    @gained_badges = []

    Badge.active.each do |badge|
      @gained_badges += [add_badge_to_user(badge)] if gain?(badge)
    end
    @gained_badges
  end

  private

  def gain?(badge)
    self.send("#{badge.badge_type.b_type}_gain?".to_sym, badge)
  end

  def no_fails_passage_gain?(badge)
    return false unless @passed

    if object_type == 'Test' && object_id == @test.id
      !@user.failed_tests.find_by(id: @test.id)
    else
      false
    end
  end

  def whole_category_passed_gain?(badge)
    return false unless @passed

    if object_type == 'Category' && object_id == @category.id
      # это интересующий нас бейдж, проверяем все ли тесты пройдены по этой категории
      success_category_test_passed = @user.success_tests.where(category: category).pluck(:id).uniq.sort
      all_category_test = category.tests.pluck(:id).sort

      success_category_test_passed == all_category_test
    else
      false
    end
  end

  def whole_level_passed_gain?(badge)
    return false unless @passed

    if object_type == 'Level' && object_id == @level
      success_level_test_passed = @user.success_tests.where(level: object_id).pluck(:id).uniq.sort
      all_level_test = Test.where(level: object_id).pluck(:id).sort

      success_level_test_passed == all_level_test
    else
      false
    end

  end

  def try_again_gain?(test_passage)
    return false if @passed

    fails = @user.test_passages.where(test: @test, passed: false).count
    fails >= 3
  end

  def add_badge_to_user(badge)
    user_badge = @user.user_badges.find_by(badge_id: badge.id)
    if user_badge
      user_badge.count += 1
      user_badge.save!
    else
      @user.user_badges.create!(badge_id: badge.id, count: 1)
    end
    badge
  end

end