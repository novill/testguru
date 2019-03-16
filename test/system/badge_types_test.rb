require "application_system_test_case"

class BadgeTypesTest < ApplicationSystemTestCase
  setup do
    @badge_type = badge_types(:one)
  end

  test "visiting the index" do
    visit badge_types_url
    assert_selector "h1", text: "Badge Types"
  end

  test "creating a Badge type" do
    visit badge_types_url
    click_on "New Badge Type"

    fill_in "Name", with: @badge_type.name
    fill_in "Type", with: @badge_type.type
    click_on "Create Badge type"

    assert_text "Badge type was successfully created"
    click_on "Back"
  end

  test "updating a Badge type" do
    visit badge_types_url
    click_on "Edit", match: :first

    fill_in "Name", with: @badge_type.name
    fill_in "Type", with: @badge_type.type
    click_on "Update Badge type"

    assert_text "Badge type was successfully updated"
    click_on "Back"
  end

  test "destroying a Badge type" do
    visit badge_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Badge type was successfully destroyed"
  end
end
