module TestsHelper
  TEST_LEVELS = { 0 => 'легкий',
                  1 => 'простой',
                  2 => 'сложный',
                  3 => 'трудный' }.freeze

  def test_level(test)
    TEST_LEVELS[test.level] || 'не задан'
  end
end
